//
//  AuthorizationViewModelImpl.swift
//  ShoppingMall
//
//  Created by Diana Brik on 06.11.2024.
//

import Foundation
import Combine

class AuthorizationViewModel: ObservableObject {
    @Published var user = UserModel()
    @Published var isPhoneNumberValid = false
    @Published var isProfileDataValid = false
    @Published var isCodeSent = false
    @Published var isCodeValid = false
    @Published var showErrorMessage = false
    @Published var errorMessage = ""
    @Published var isCodeResendAllowed = false
    @Published var countdownText = ""
    @Published var smsCode: String = "" {
        didSet {
            if smsCode.count > 6 {
                smsCode = String(smsCode.prefix(6))
            }
        }
    }
    @Published var isDataSavedSuccessfully: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let mobileDeviceId = DeviceManager.shared.mobileDeviceId
    @Published var resendTimerSeconds = 60
        
    private var resendTimer: Timer?

    init() {
        $user
            .map { $0.phoneNumber.count >= 10 }
            .assign(to: \.isPhoneNumberValid, on: self)
            .store(in: &cancellables)
        
        $user
            .map { !$0.firstName.isEmpty && !$0.lastName.isEmpty && $0.email.contains("@") }
            .assign(to: \.isProfileDataValid, on: self)
            .store(in: &cancellables)
    }
    
    func checkCodeValidity() {
        isCodeValid = user.smsCode.count == 6
    }

    func sendPhoneNumber() {
        guard let url = URL(string: "https://skillbox.dev.instadev.net/api/v1/mobile-users/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters = ["phone": user.phoneNumber]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                switch response.statusCode {
                case 200, 201:
                    return result.data
                default:
                    throw URLError(.badServerResponse)
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.showErrorMessage = true
                    self.errorMessage = "Ошибка отправки номера: \(error.localizedDescription)"
                }
            }, receiveValue: { _ in
                self.isCodeSent = true
                self.showErrorMessage = false
                self.startResendTimer()
                print("Код успешно отправлен")
            })
            .store(in: &cancellables)
    }
    
    func validateCode() {
        guard let url = URL(string: "https://skillbox.dev.instadev.net/api/v1/mobile-users/auth") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters = ["phone": user.phoneNumber, "smsCode": user.smsCode, "mobileDeviceId": mobileDeviceId]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.showErrorMessage = true
                    self.errorMessage = "Неверный код: \(error.localizedDescription)"
                }
            }, receiveValue: { data in
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Ответ от сервера: \(jsonString)")
                }
                
                do {
                    let response = try JSONDecoder().decode(ValidateCodeResponse.self, from: data)
                    DispatchQueue.main.async {
                        print("Код успешно проверен. User id: \(response.id)")
                        self.isCodeValid = true
                        self.showErrorMessage = false
                        UserDefaults.standard.set(response.referralCode, forKey: "referralCode")
                        UserDefaults.standard.set(response.rememberToken, forKey: "token")
                        UserDefaults.standard.set(response.phone, forKey: "phone")
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.showErrorMessage = true
                        self.errorMessage = "Ошибка декодирования данных: \(error.localizedDescription)"
                        print("Ошибка декодирования: \(error.localizedDescription)")
                    }
                }
            })
            .store(in: &cancellables)
    }
    
    func saveProfileData() {
        guard !user.firstName.isEmpty, !user.lastName.isEmpty, !user.email.isEmpty else {
            errorMessage = "Все поля должны быть заполнены"
            return
        }
        
        let referralCode = UserDefaults.standard.string(forKey: "referralCode")
        let token = UserDefaults.standard.string(forKey: "token")
        
        guard let url = URL(string: "https://skillbox.dev.instadev.net/api/v1/mobile-users/\(String(describing: mobileDeviceId))") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = [
            "token": token as Any,
            "name": "\(user.firstName) \(user.lastName)",
            "email": user.email,
            "gender": "",
            "registration_by_promo_code": false,
            "referral_code": referralCode as Any,
            "enable_push_promotion": false,
            "enable_push_event": false,
            "enable_push_children": false,
            "finish_poll": false,
            "date_birth": 0,
            "have_kids": false,
            "count_invited_users": 0,
            "total_points_accumulated": 0,
            "total_points_spent": 0,
            "count_offers_purchased": 0,
            "maximum_purchased_offers": 0,
            "app_evaluation": 0
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.showErrorMessage = true
                    self.errorMessage = "Ошибка сохранения данных профиля: \(error.localizedDescription)"
                }
            }, receiveValue: { data in
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Ответ от сервера: \(jsonString)")
                }
                
                do {
                    let response = try JSONDecoder().decode([SaveProfileDataResponse].self, from: data)
                    if let first = response.first {
                        self.isDataSavedSuccessfully = true
                        self.showErrorMessage = false
                        print("Данные успешно сохранены. Имя: \(first.name), email код: \(first.email)")
                    }
                } catch {
                    self.showErrorMessage = true
                    self.errorMessage = "Ошибка декодирования данных: \(error.localizedDescription)"
                    print("Ошибка декодирования: \(error.localizedDescription)")
                }
            })
            .store(in: &cancellables)
    }
    
    func startResendTimer() {
        resendTimer?.invalidate()
        resendTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.resendTimerSeconds > 0 {
                self.resendTimerSeconds -= 1
            } else {
                self.isCodeResendAllowed = true
                timer.invalidate()
            }
        }
    }
    
    func resetResendTimer() {
        isCodeResendAllowed = false
        resendTimerSeconds = 60
        startResendTimer()
    }
}
