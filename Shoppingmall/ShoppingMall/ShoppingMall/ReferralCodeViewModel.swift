//
//  ReferralCodeViewModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import Combine
import SwiftUI

class ReferralCodeViewModel: ObservableObject {
    @Published var promoCode: String = ""
    @Published var isPromoCodeValid: Bool = false
    @Published var alertItem: AlertItem?
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    private let mobileDeviceID: String
    private let token: String
    
    init(mobileDeviceID: String, token: String) {
        self.mobileDeviceID = mobileDeviceID
        self.token = token
        $promoCode
            .map { code in
                return code.count == 5
            }
            .assign(to: \.isPromoCodeValid, on: self)
            .store(in: &cancellables)
    }
    
    func validatePromoCode() {
        //TODO: Не знаю с каким кодом сравнивать, нет запроса, на проверку промокода
        if promoCode == "ABCDF" {
            applyPromoCode()
        } else {
            alertItem = AlertItem(message: Constants.Text.referralCodeViewModelInvalidAlertMessage)
        }
    }
    
    private func applyPromoCode() {
        guard !promoCode.isEmpty else {
            alertItem = AlertItem(message: Constants.Text.referralCodeViewModelEmptyAlertMessage)
            return
        }
        
        isLoading = true
        
        let request = UpdateUserRequest(
            token: token,
            name: "User Name",
            email: "user@example.com",
            gender: "M",
            registrationByPromoCode: true,
            referralCode: promoCode,
            enablePushPromotion: true,
            enablePushEvent: true,
            enablePushChildren: true,
            finishPoll: true,
            dateBirth: 0,
            haveKids: true,
            countInvitedUsers: 0,
            totalPointsAccumulated: 0,
            totalPointsSpent: 0,
            countOffersPurchased: 0,
            maximumPurchasedOffers: 0,
            appEvaluation: 0
        )
        
        let url = URL(string: "https://skillbox.dev.instadev.net/api/v1/mobile-users/\(String(describing: mobileDeviceID))")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let encodedData = try JSONEncoder().encode(request)
                urlRequest.httpBody = encodedData
            } catch {
                print("Ошибка кодирования данных: \(error.localizedDescription)")
                isLoading = false
                return
            }
            
            URLSession.shared.dataTaskPublisher(for: urlRequest)
                .map { _ in }
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print("Ошибка: \(error.localizedDescription)")
                    case .finished:
                        break
                    }
                    self.isLoading = false
                }, receiveValue: {
                    self.alertItem = AlertItem(message: Constants.Text.referralCodeViewModelReadyAlertMessage)
                })
                .store(in: &cancellables)
    }
}
