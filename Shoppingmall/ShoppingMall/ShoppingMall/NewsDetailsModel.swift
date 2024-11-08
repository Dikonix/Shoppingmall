//
//  NewsDetailsModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 29.10.2024.
//

import SwiftUI
import Combine

struct NewsDetail: Identifiable, Decodable {
    let id: UUID
    let title: String
    let logoUrl: String
    let content: String
    let publishDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case logoUrl = "logo_url"
        case content
        case publishDate = "publish_date"
    }
}

protocol NewsDetailsRepository{
    func getNewsDetails(id: UUID)  -> AnyPublisher<NewsDetail, Never>
}

class DefaultNewsDetailsRepository: NewsDetailsRepository {
    func getNewsDetails(id: UUID) -> AnyPublisher<NewsDetail, Never> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: "https://skillbox.dev.instadev.net/api/v1/news/\(id)")!)
            .map { $0.data }
            .decode(type: NewsDetail.self, decoder: JSONDecoder())
            .replaceError(with: NewsDetail(id: UUID(), title: "", logoUrl: "", content: "", publishDate: ""))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
