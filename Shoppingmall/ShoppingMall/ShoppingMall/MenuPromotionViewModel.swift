//
//  MenuPromotionViewModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 02.11.2024.
//

import SwiftUI
import Combine

class MenuPromotionViewModel: MenuPromotionDetailViewModel {
    @Published private(set) var promotion: PromotionDTO?
    private var cancellables: [AnyCancellable] = []
    private let promotionId: UUID
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    let defaultPromotion = DefaultMenuPromotions()
    
    init(promotionId: UUID) {
        self.promotionId = promotionId
        
        defaultPromotion.getMenuPromotions(promotionId: promotionId)
            .sink(receiveValue: { [weak self] promotion in
                self?.promotion = promotion.toPromotionDTO
                print("Promotion: \(promotion)")
            })
            .store(in: &cancellables)
    }
}

extension MenuPromotion {
    var toPromotionDTO: PromotionDTO? {
        PromotionDTO(
            id: self.id,
            title: self.title,
            startDate: self.startDate,
            endDate: self.finishDate,
            description: self.disclaimer,
            coverSource: URL(string: self.logoUrl))
    }
}

