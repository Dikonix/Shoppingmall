//
//  NoDataView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 29.10.2024.
//

import SwiftUI

struct NoDataView: View {
    var text: String
    var body: some View {
        VStack {
            Text(text)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal, 16)
                .font(.system(size: 18))
            Image(uiImage: UIImage.noResults)
                .resizable()
                .frame(width: 294, height: 294, alignment: .center)
                .padding(.top, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    NoDataView(text: Constants.Text.homeViewNoData)
}
