//
//  MenuPromotionModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 02.11.2024.
//

import SwiftUI
import Combine

struct MenuPromotion: Identifiable, Decodable {
    let id: UUID
    let title: String
    let logoUrl: String
    let disclaimer: String
    let startDate: String
    let finishDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case logoUrl = "logo_url"
        case disclaimer
        case startDate = "start_date"
        case finishDate = "finish_date"
    }
}

protocol MenuPromotionsRepository {
    func getMenuPromotions(promotionId: UUID) -> AnyPublisher<MenuPromotion, Never>
}

class DefaultMenuPromotions: MenuPromotionsRepository {
    func getMenuPromotions(promotionId: UUID) -> AnyPublisher<MenuPromotion, Never> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: "https://skillbox.dev.instadev.net/api/v1/promotions/\(promotionId)")!)
            .map { $0.data }
            .decode(type: MenuPromotion.self, decoder: JSONDecoder())
            .replaceError(with: MenuPromotion(id: UUID(), title: "", logoUrl: "", disclaimer: "", startDate: "", finishDate: ""))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
