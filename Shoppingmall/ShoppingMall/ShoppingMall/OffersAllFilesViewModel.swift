//
//  OffersAllFilesViewModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 06.11.2024.
//

import SwiftUI
import Combine

class OffersAllFilesViewModel: NewsViewModel {
    @Published private(set) var news: [NewsDTO] = []
    private var cancellables: [AnyCancellable] = []
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    let offersRepository = DefaultOffersRepository()
    
    init() {
        offersRepository.getOffers()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("done")
                }
            } receiveValue: { [weak self] offers in
                self?.news.append(contentsOf: offers.toNewsDTO)
                print("Offers: \(offers)")
            }
            .store(in: &cancellables)
    }
}

extension Array<Offer> {
    var toNewsDTO: [NewsDTO] {
        self.map { item in
                .init(title: item.name, subtitle: "", description: item.description, coverSource: URL(string: item.image))
        }
    }
}
