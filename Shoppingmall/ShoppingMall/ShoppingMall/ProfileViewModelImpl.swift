//
//  ProfileViewModelImpl.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import SwiftUI
import Combine

class ProfileViewModelImpl: ProfileViewModel {
    @Published private(set) var data: ProfileDataDTO?
    private var cancellables = Set<AnyCancellable>()
    private let mobileDeviceId: String
    @Published var showErrorMessage = false
    @Published var errorMessage = ""
    
    let profileDataRepository = DefaultProfileDataRepository()
    
    init(mobileDeviceId: String) {
        self.mobileDeviceId = mobileDeviceId
        
        profileDataRepository.getUserProfile(mobileUserID: mobileDeviceId)
            .sink(receiveValue: { [weak self] data in
                self?.data = data.toProfileDataDTO
                print("Profile data: \(data)")
            })
            .store(in: &cancellables)
    }
    
    func saveProfileData() {
        let referralCode = UserDefaults.standard.string(forKey: "referralCode")
        let token = UserDefaults.standard.string(forKey: "token")
        
        guard let url = URL(string: "https://skillbox.dev.instadev.net/api/v1/mobile-users/\(String(describing: mobileDeviceId))") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any] = [
            "token": token as Any,
            "name": "\(String(describing: data?.name)) \(String(describing: data?.surname))",
            "email": data?.email ?? "",
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
                    self.errorMessage = Constants.Text.profileViewModelImplErrorMessage + " \(error.localizedDescription)"
                }
            }, receiveValue: { data in
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Ответ от сервера: \(jsonString)")
                }
                
                do {
                    let response = try JSONDecoder().decode([SaveProfileDataResponse].self, from: data)
                    if let first = response.first {
                        self.showErrorMessage = false
                        print("Данные успешно сохранены. Имя: \(first.name), email код: \(first.email)")
                    }
                } catch {
                    self.showErrorMessage = true
                    self.errorMessage = Constants.Text.loginViewModelDecodingErrorMessage + " \(error.localizedDescription)"
                    print("Ошибка декодирования: \(error.localizedDescription)")
                }
            })
            .store(in: &cancellables)
    }
}

extension ProfileData {
    var toProfileDataDTO: ProfileDataDTO {
        let nameComponents = self.name.split(separator: " ")
        let firstName = nameComponents.first ?? ""
        let lastName = nameComponents.dropFirst().joined(separator: " ")
        
        return ProfileDataDTO(phone: self.phone, name: String(firstName), surname: lastName, email: self.email)
    }
}

