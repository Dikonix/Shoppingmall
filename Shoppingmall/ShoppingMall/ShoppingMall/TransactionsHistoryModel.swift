//
//  TransactionsHistoryModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 01.11.2024.
//

import SwiftUI
import Combine

struct TransactionsHistory: Identifiable, Decodable {
    //Не знаю где брать дату транзакции, чтобы разбивать по датам операции, возможно это CreatedAt, не могу проверить, данных нет
    let id: UUID
    let changeBalance: Int
    let typeTransaction: String
    let typeObject: String
    let createdAt: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case changeBalance = "change_balance"
        case typeTransaction = "type_transaction"
        case typeObject = "type_object"
        case createdAt = "created_at"
    }
}

protocol TransactionsHistoryRepository {
    func getTransactionHistory() -> AnyPublisher<[TransactionsHistory], Never>
}

class DefaultTransactionsHistoryRepository: TransactionsHistoryRepository {
    let mobileUserID = DeviceManager.shared.mobileDeviceId
    
    func getTransactionHistory() -> AnyPublisher<[TransactionsHistory], Never> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: "https://skillbox.dev.instadev.net/api/v1/mobile-users/\(String(describing: mobileUserID))/offers")!)
            .map { $0.data }
            .decode(type: [TransactionsHistory].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
