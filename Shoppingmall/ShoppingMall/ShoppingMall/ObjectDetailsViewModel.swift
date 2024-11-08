//
//  ObjectDetailsViewModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 30.10.2024.
//

import SwiftUI
import Combine

class ObjectDetailsViewModel: DetailsViewModel {    
    @Published private(set) var details: DetailsInfoDTO? = nil
    private var cancellables: [AnyCancellable] = []
    private let shopId: UUID
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    let defaultCategoryObject = DefaultCategoryObjectRepository()
    
    init(shopId: UUID) {
        self.shopId = shopId
        
        defaultCategoryObject.getCategoryObjects(shopId: shopId)
            .sink(receiveValue: { [weak self] categoryObject in
                self?.details = categoryObject.toDetailsInfoDTO
                print("Details: \(categoryObject)")
            })
            .store(in: &cancellables)
    }
}

extension CategoryObject {
    var toDetailsInfoDTO: DetailsInfoDTO {
        DetailsInfoDTO(
            title: self.name,
            description: self.description,
            coverImageSource: URL(string: self.logoUrl),
            locationTitle: String(self.floor),
            siteName: URL(string: self.siteUrl)?.host(),
            siteAddress: URL(string: self.siteUrl)
        )
    }
}



