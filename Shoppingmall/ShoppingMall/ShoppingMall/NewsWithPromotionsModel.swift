//
//  NewsWithPromotionsModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 02.11.2024.
//

import SwiftUI
import Combine

struct NewsWithPromotions: Identifiable, Decodable {
    let id: UUID
    let type: String
    let title: String
    let logoUrl: String
    let date: Dictionary<String, String>?
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case title
        case logoUrl = "logo_url"
        case date
    }
}

protocol NewsWithPromotionsRepository {
    func getNewsWithPromotions() -> AnyPublisher<[NewsWithPromotions], Never>
}

class DefaultNewsWithPromotions: NewsWithPromotionsRepository {
    func getNewsWithPromotions() -> AnyPublisher<[NewsWithPromotions], Never>{
        return URLSession.shared.dataTaskPublisher(for: URL(string: "https://skillbox.dev.instadev.net/api/v1/news/with/promotions")!)
            .map { $0.data }
            .decode(type: [NewsWithPromotions].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
