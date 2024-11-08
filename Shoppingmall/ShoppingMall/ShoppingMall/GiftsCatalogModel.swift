//
//  GiftsCatalogModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 01.11.2024.
//

import SwiftUI
import Combine

struct GiftCatalog: Identifiable, Decodable {
    let id: UUID
    let name: String
    let disclaimer: String
    let description: String
    let image: String
    let cost: Int
}

protocol GiftsCatalogRepository {
    func getGiftsCatalog() -> AnyPublisher<[GiftCatalog], Never>
}

class DefaultGiftsCatalogRepository: GiftsCatalogRepository {
    func getGiftsCatalog() -> AnyPublisher<[GiftCatalog], Never> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: "https://skillbox.dev.instadev.net/api/v1/offers")!)
            .map { $0.data }
            .decode(type: [GiftCatalog].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
