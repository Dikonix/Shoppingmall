//
//  NewsAllFilesViewModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 06.11.2024.
//

import SwiftUI
import Combine

class NewsAllFilesViewModel: NewsViewModel {
    @Published private(set) var news: [NewsDTO] = []
    private var cancellables: [AnyCancellable] = []
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    let newsAndEventsRepository = DefaultNewsAndEventsRepository()
    
    init() {
        newsAndEventsRepository.getNewsAndEvents()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("done")
                }
            } receiveValue: { [weak self] newsAndEvent in
                self?.news.append(contentsOf: newsAndEvent.toNewsDTO)
                print("News: \(newsAndEvent)")
            }
            .store(in: &cancellables)
    }
}

extension Array<NewsAndEvent> {
    var toNewsDTO: [NewsDTO] {
        self.map { item in
                .init(title: item.title, subtitle: "", description: "", coverSource: URL(string: item.logoUrl))
        }
    }
}
