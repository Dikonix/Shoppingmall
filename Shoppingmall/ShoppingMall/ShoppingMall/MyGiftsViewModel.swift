//
//  MyGiftsViewModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import SwiftUI
import Combine

class MyGiftsViewModel: MyGiftsCatalogViewModel {
    @Published private(set) var gifts: [MyGiftCardDTO] = []
    private var cancellables: [AnyCancellable] = []
    private let mobileDeviceId: String
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    let myGifts = DefaultMyGiftsRepository()
    
    init(mobileDeviceId: String) {
        self.mobileDeviceId = mobileDeviceId
        
        myGifts.getMyGifts(mobileDeviceId: mobileDeviceId)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("done")
                }
            } receiveValue: { [weak self] myGifts in
                self?.gifts = myGifts.toMyGiftCardDTO
                print("Gift Details: \(myGifts)")
            }
            .store(in: &cancellables)
    }
}

extension Array<MyGifts> {
    var toMyGiftCardDTO: [MyGiftCardDTO] {
        self.map { detail in
            MyGiftCardDTO(title: detail.name, subtitle: detail.disclaimer, storeTitle: detail.description)
        }
    }
}

