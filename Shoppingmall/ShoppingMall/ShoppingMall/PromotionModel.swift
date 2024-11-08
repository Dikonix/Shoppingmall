//
//  PromotionModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 31.10.2024.
//

import SwiftUI
import Combine

struct Promotion: Identifiable, Decodable {
    let id: UUID
    let title: String
    let disclaimer: String
    let logoUrl: String
    let content: String
    let startDate: String
    let finishDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case disclaimer
        case content
        case logoUrl = "logo_url"
        case startDate = "start_date"
        case finishDate = "finish_date"
    }
}

protocol PromotionsRepository {
    func getPromotions(shopId: UUID) -> AnyPublisher<[Promotion], Never>
}

class DefaultPromotionsRepository: PromotionsRepository {
    func getPromotions(shopId: UUID) -> AnyPublisher<[Promotion], Never> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: "https://skillbox.dev.instadev.net/api/v1/shops/\(shopId)/promotions")!)
            .map { $0.data }
            .decode(type: [Promotion].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
