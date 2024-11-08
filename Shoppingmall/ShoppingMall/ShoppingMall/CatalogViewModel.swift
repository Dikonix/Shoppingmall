//
//  CatalogViewModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 30.10.2024.
//

import SwiftUI

class CatalogViewModelImpl: CatalogViewModel {
    @Published var items: [CatalogItem] = [
        CatalogItem(title: Constants.Text.catalogViewModelShops, imageName: "cart.fill", slug: "shops"),
        CatalogItem(title: Constants.Text.catalogViewModelFood, imageName: "fork.knife", slug: "food"),
        CatalogItem(title: Constants.Text.catalogViewModelEntertainment, imageName: "gamecontroller.fill", slug: "entertainment"),
        CatalogItem(title: Constants.Text.catalogViewModelServices, imageName: "wrench.fill", slug: "services"),
        CatalogItem(title: Constants.Text.catalogViewModelFitness, imageName: "heart.fill", slug: "sport"),
        CatalogItem(title: Constants.Text.catalogViewModelMovie, imageName: "film.fill", slug: "cinema")
    ]
}
