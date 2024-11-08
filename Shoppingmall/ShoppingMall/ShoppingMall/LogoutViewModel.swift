//
//  LogoutViewModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import SwiftUI
import Combine

class LogoutViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let logoutService: LogoutService
    
    init(logoutService: LogoutService = DefaultLogoutService()) {
        self.logoutService = logoutService
    }
    
    func logout() {
        guard let mobileDeviceId = UserDefaults.standard.string(forKey: "mobileDeviceId"),
              let token = UserDefaults.standard.string(forKey: "token") else {
            print("Ошибка: Нет данных в UserDefaults")
            return
        }
        
        logoutService.logout(mobileDeviceId: mobileDeviceId, token: token)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Успешный выход из учетной записи")
                case .failure(let error):
                    print("Ошибка: \(error.localizedDescription)")
                }
            }, receiveValue: { response in
                if response.success {
                    print("Выход успешен: \(response.message)")
                } else {
                    print("Ошибка при выходе: \(response.message)")
                }
            })
            .store(in: &cancellables)
    }
}
