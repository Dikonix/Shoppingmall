//
//  BonusPointsViewModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import SwiftUI
import Combine

class BonusPointsViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var isTransactionAdded = false
    private var cancellables = Set<AnyCancellable>()
    private let transactionService = BonusPointsModel()
    
    func addRegisterTransaction() {
        guard let mobileUserID = DeviceManager.shared.mobileDeviceId else {
            errorMessage = Constants.Text.bonusPointsModelViewErrorMessage
            return
        }
        
        transactionService.addRegisterTransaction(for: mobileUserID)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isTransactionAdded = true
                    self.errorMessage = nil
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { _ in
            })
            .store(in: &cancellables)  // Сохраняем ссылку на подписку
    }
}

