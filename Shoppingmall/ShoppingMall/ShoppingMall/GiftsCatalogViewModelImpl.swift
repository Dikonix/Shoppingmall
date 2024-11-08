//
//  GiftsCatalogViewModelImpl.swift
//  ShoppingMall
//
//  Created by Diana Brik on 01.11.2024.
//

import SwiftUI
import Combine

class GiftsCatalogViewModelImpl: GiftsCatalogViewModel {
    @Published private(set) var gifts: [GiftCardDTO] = []
    private var cancellables: [AnyCancellable] = []
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    let giftsCatalog = DefaultGiftsCatalogRepository()
    
    init() {
        giftsCatalog.getGiftsCatalog()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("done")
                }
            } receiveValue: { [weak self] giftsCatalog in
                self?.gifts = giftsCatalog.toGiftCardDTO
                print("Gift Details: \(giftsCatalog)")
            }
            .store(in: &cancellables)
    }
}


extension Array<GiftCatalog> {
    var toGiftCardDTO: [GiftCardDTO] {
        self.map { detail in
            GiftCardDTO(title: detail.disclaimer, subtitle: "", description: detail.description, coverSource: URL(string: detail.image)!, storeTitle: detail.name, price: detail.cost)
        }
    }
}
