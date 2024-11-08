//
//  OffersViewModelImpl.swift
//  ShoppingMall
//
//  Created by Diana Brik on 31.10.2024.
//

import SwiftUI
import Combine

class PromotionViewModelImpl: PromotionViewModel {
    @Published private(set) var promotions: HomeSectionDTO? = nil
    private var cancellables: [AnyCancellable] = []
    private let shopId: UUID
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    let defaultPromotions = DefaultPromotionsRepository()
    
    init(shopId: UUID) {
        self.shopId = shopId
        
        defaultPromotions.getPromotions(shopId: shopId)
            .sink(receiveValue: { [weak self] promotionsItem in
                self?.promotions = promotionsItem.toHomeSectionDTO
                print("Promotions: \(promotionsItem)")
            })
            .store(in: &cancellables)
    }
}

extension Array<Promotion> {
    var toHomeSectionDTO: HomeSectionDTO {
        HomeSectionDTO(
            title: Constants.Text.promotionViewModelImplTitle,
            size: .small,
            items: self.map { item in .init(title: item.title, description: item.disclaimer, backgroundColor: Color(uiColor: Constants.Colors.purple ?? .purple), coverImageSource: URL(string: item.logoUrl), brightness: .dark)}, destinationView: .offers
        )
    }
}

