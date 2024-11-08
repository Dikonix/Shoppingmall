//
//  CatalogModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 30.10.2024.
//

import Foundation

struct CatalogItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let imageName: String
    let slug: String
}
