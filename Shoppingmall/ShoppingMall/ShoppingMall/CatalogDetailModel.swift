//
//  CatalogDetailModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 30.10.2024.
//

import SwiftUI
import Combine

struct CategoryDetail: Identifiable, Decodable {
    let id: UUID
    let name: String
    let logoUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logoUrl = "logo_url"
    }
}

protocol CategoryDetailsRepository {
    func getCategoryDetails(slug: String) -> AnyPublisher<[CategoryDetail], Never>
}

class DefaultCategoryDetailsRepository: CategoryDetailsRepository {
    func getCategoryDetails(slug: String) -> AnyPublisher<[CategoryDetail], Never> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: "https://skillbox.dev.instadev.net/api/v1/shops/category/slug/\(slug)")!)
            .map { $0.data }
            .decode(type: [CategoryDetail].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
