//
//  CatalogView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 13.08.2024.
//

import SwiftUI

struct CatalogView: View {
    var body: some View {
        ScrollView {
            VStack {
                Image(uiImage: UIImage.shoppingmall)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 312, height: 18.24)
                    .padding()
            }
        }
    }
}

#Preview {
    CatalogView()
}
