//
//  ObjectDetailsModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 30.10.2024.
//

import SwiftUI
import Combine

struct CategoryObject: Identifiable, Decodable {
    let id: UUID
    let name: String
    let logoUrl: String
    let floor: Int
    let siteUrl: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logoUrl = "logo_url"
        case floor
        case siteUrl = "site_url"
        case description
    }
}

protocol CategoryObjectRepository {
    func getCategoryObjects(shopId: UUID) -> AnyPublisher<CategoryObject, Never>
}

class DefaultCategoryObjectRepository: CategoryObjectRepository {
    func getCategoryObjects(shopId: UUID) -> AnyPublisher<CategoryObject, Never> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: "https://skillbox.dev.instadev.net/api/v1/shops/\(shopId)")!)
            .map { $0.data }
            .decode(type: CategoryObject.self, decoder: JSONDecoder())
            .replaceError(with: CategoryObject(id: UUID(), name: "", logoUrl: "", floor: 0, siteUrl: "", description: ""))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
