//
//  NewsWithPromotionsViewModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 02.11.2024.
//

import SwiftUI
import Combine

class NewsWithPromotionsViewModel: MenuNewsViewModel {
    @Published private(set) var title = ""
    @Published private(set) var news: [MenuNewsDTO] = []
    private var cancellables: [AnyCancellable] = []
    private let menuTitle: String
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    let newsWithPromotions = DefaultNewsWithPromotions()
    
    init(menuTitle: String) {
        self.menuTitle = menuTitle
        self.title = menuTitle
        
        getNews()
    }
    
    func getNews() {
        newsWithPromotions.getNewsWithPromotions()
            .sink { completion in
            switch completion {
            case .failure(let error):
                print(error)
            case .finished:
                print("done")
            }
        } receiveValue: { [weak self] newsWithPromotions in
            self?.news = newsWithPromotions.toMenuNewsDTO
            print("News with Promotions: \(newsWithPromotions)")
        }
        .store(in: &cancellables)
    }
}

extension Array<NewsWithPromotions> {
    var toMenuNewsDTO: [MenuNewsDTO] {
        self.map { item in
            let startDate = item.date?["start"] ?? ""
            let endDate = item.date?["finish"] ?? ""
            
            return MenuNewsDTO(id: item.id, title: item.title, type: item.type, startDate: startDate, endDate: endDate, description: "", coverSource: URL(string: item.logoUrl)!)
        }
    }
}
