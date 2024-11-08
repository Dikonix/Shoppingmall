//
//  NewsDetailsViewModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 02.11.2024.
//

import SwiftUI
import Combine

class NewsDetailsViewModel: NewsDetailViewModel {
    @Published private(set) var newsDetails: NewsDetailsDTO?
    private var cancellables: [AnyCancellable] = []
    private let newsId: UUID
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    let defaultNewsDetails = DefaultNewsDetailsRepository()
    
    init(newsId: UUID) {
        self.newsId = newsId
        
        defaultNewsDetails.getNewsDetails(id: newsId)
            .sink(receiveValue: { [weak self] newsDetails in
                self?.newsDetails = newsDetails.toNewsDetailsDTO
                print("News Details: \(newsDetails)")
            })
            .store(in: &cancellables)
    }
}

extension NewsDetail {
    var toNewsDetailsDTO: NewsDetailsDTO {
        NewsDetailsDTO(
            id: self.id,
            title: self.title,
            publishedDate: self.publishDate,
            description: self.content,
            coverSource: URL(string: self.logoUrl))
    }
}
