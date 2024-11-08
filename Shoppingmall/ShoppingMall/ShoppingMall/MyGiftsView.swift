//
//  MyGiftsView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 11.10.2024.
//

import SwiftUI

struct MyGiftCardDTO: Hashable {
    let title: String
    let subtitle: String
    let storeTitle: String
}

protocol MyGiftsCatalogViewModel: ObservableObject {
    var gifts: [MyGiftCardDTO] { get }
}

struct MyGiftsCatalogView<ViewModel: MyGiftsCatalogViewModel>: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    private var columns: [GridItem] = [
        GridItem(.fixed(160), spacing: 8),
        GridItem(.fixed(160), spacing: 8)
    ]
    
    var body: some View {
        ScrollView {
            if viewModel.gifts.isEmpty {
                NoDataView(text: Constants.Text.homeViewNoData)
            } else {
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: 8
                ) {
                    ForEach(viewModel.gifts, id: \.self) { gift in
                        GiftCard(gift: gift)
                    }
                }
            }
        }
    }
}

private struct GiftCard: View {
    let gift: MyGiftCardDTO
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(gift.storeTitle)
                .font(.callout)
                .padding(.bottom, 4)
            Text(gift.title)
                .font(.headline)
            Text(gift.subtitle)
                .font(.subheadline)
        }
        .padding()
        .frame(width: 160, height: 160)
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    MyGiftsCatalogView(viewModel: MockMyGiftsCatalogViewModel())
}

class MockMyGiftsCatalogViewModel: MyGiftsCatalogViewModel {
    @Published private(set) var gifts: [MyGiftCardDTO]
    
    init() {
        self.gifts = [
            MyGiftCardDTO(
                title: "15% скидка",
                subtitle: "На первую покупку",
                storeTitle: "ZARA"
            ),
            MyGiftCardDTO(
                title: "10% скидка",
                subtitle: "На первую покупку",
                storeTitle: "ZARA"
            ),
            MyGiftCardDTO(
                title: "5% скидка",
                subtitle: "На первую покупку",
                storeTitle: "ZARA"
            ),
            MyGiftCardDTO(
                title: "10% скидка",
                subtitle: "На заказ через приложение",
                storeTitle: "DNS"
            ),
            MyGiftCardDTO(
                title: "5% скидка",
                subtitle: "На заказ через приложение",
                storeTitle: "DNS"
            ),
            MyGiftCardDTO(
                title: "2% скидка",
                subtitle: "На первую покупку",
                storeTitle: "ZARA"
            )
        ]
    }
}
