//
//  CatalogDetailViewModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 30.10.2024.
//

import SwiftUI
import Combine

class CatalogDetailViewModel: CategoryViewModel {
    @Published private(set) var title = ""
    @Published private(set) var items: [CategoryItemDTO] = []
    private var cancellables: [AnyCancellable] = []
    private let slug: String
    private let catalogDetailTitle: String
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    let categoryDetails = DefaultCategoryDetailsRepository()
    
    init(slug: String, catalogDetailTitle: String) {
        self.slug = slug
        self.catalogDetailTitle = catalogDetailTitle
        self.title = catalogDetailTitle
    }
    
    func getCategoryDetails() {
        categoryDetails.getCategoryDetails(slug: slug)
            .sink { completion in
            switch completion {
            case .failure(let error):
                print(error)
            case .finished:
                print("done")
            }
        } receiveValue: { [weak self] categoryDetails in
            self?.items = categoryDetails.toCategoryItemDTO
            print("Catalog Details: \(categoryDetails)")
        }
        .store(in: &cancellables)
    }
}

extension Array<CategoryDetail> {
    var toCategoryItemDTO: [CategoryItemDTO] {
        self.map { detail in
            CategoryItemDTO(id: detail.id, title: detail.name, image: URL(string: detail.logoUrl)!)
        }
    }
}
