//
//  CatalogView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 13.08.2024.
//

import SwiftUI

protocol CatalogViewModel: ObservableObject {
    var items: [CatalogItem] { get }
}

struct CatalogView<ViewModel: CatalogViewModel & ObservableObject>: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Text(Constants.Text.catalog)
                .font(.largeTitle)
                .padding(.top, -60)
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.items, id: \.self) { item in
                    NavigationLink(value: item) {
                        TileView(catalogItem: item)
                    }
                }
            }
            .padding()
        }
    }
    
}

struct TileView: View {
    let catalogItem: CatalogItem
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 152, height: 152)
            
            VStack {
                Image(systemName: catalogItem.imageName)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Text(catalogItem.title)
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
    }
}

#Preview {
    CatalogView(viewModel: CatalogViewModelImpl())
}
