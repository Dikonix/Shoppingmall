//
//  TransactionsHistoryViewModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 01.11.2024.
//

import SwiftUI
import Combine

class TransactionsHistoryViewModel: TransactionsViewModel {
    @Published private(set) var paymentDays: [PaymentDayDTO] = []
    
    private var cancellables: [AnyCancellable] = []
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    var transactionsHistory = DefaultTransactionsHistoryRepository()
    
    init() {
        transactionsHistory.getTransactionHistory()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("done")
                }
            } receiveValue: { [weak self] transactionsHistory in
                self?.paymentDays = transactionsHistory.toPaymentDayDTO
                print("Transactions: \(transactionsHistory)")
            }
            .store(in: &cancellables)
    }
}

extension Array<TransactionsHistory> {
    var toPaymentDayDTO: [PaymentDayDTO] {
        [
            .init(formattedDate: "",
                  transactions: self.map { item in .init(actionTitle: item.typeTransaction, targetTitle: "", volume: item.changeBalance, direction: .expence)})
        ]
    }
}
