//
//  GiftCatalogueView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 11.10.2024.
//

import SwiftUI

struct GiftCardDTO: Hashable {
    let title: String
    let subtitle: String
    let description: String
    let coverSource: URL
    let storeTitle: String
    let price: Int
}

protocol GiftsCatalogViewModel: ObservableObject {
    var gifts: [GiftCardDTO] { get }
}

struct GiftsCatalogView<ViewModel: GiftsCatalogViewModel>: View {
    @State private var showingDetails = false
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
            if !viewModel.gifts.isEmpty {
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: 8
                ) {
                    ForEach(viewModel.gifts, id: \.self) { gift in
                        GiftCard(gift: gift)
                            .sheet(isPresented: $showingDetails) {
                                GiftDetails(gift: gift)
                            }
                            .onTapGesture {
                                showingDetails = true
                            }
                    }
                }
            } else {
                Spacer(minLength: 40)
                NoDataView(text: Constants.Text.homeViewNoData)
            }
        }
        .navigationTitle(Constants.Text.bonusViewGiftCatalog)
    }
}

private struct GiftCard: View {
    let gift: GiftCardDTO
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(String(gift.price))
                .font(.callout)
                .padding(.bottom)
            
            Text(gift.storeTitle)
                .font(.callout)
                .padding(.bottom, 4)
            Text(gift.title)
                .font(.headline)
            Text(gift.subtitle)
                .font(.subheadline)
        }
        .padding()
        .frame(width: 160, height: 192)
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

private struct GiftDetails: View {
    let gift: GiftCardDTO
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .topTrailing) {
                    AsyncImage(url: gift.coverSource) { image in
                        image.resizable()
                    } placeholder: {
                        Rectangle()
                            .fill(Color(red: 0.98, green: 0.98, blue: 0.95))
                    }
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Image(systemName: "xmark.square.fill")
                        .resizable()
                         .scaledToFit()
                         .frame(width: 32, height: 32)
                        .padding()
                        .onTapGesture {
                            dismiss()
                        }
                }
                
                Text(gift.title)
                    .font(.largeTitle)
                
                Text(gift.subtitle)
                    .font(.title)
                
                Divider()
                
                Text(gift.description)
                    .font(.body)
            }
            .padding(32)
        }
    }
}

#Preview {
    GiftsCatalogView(viewModel: MockGiftsCatalogViewModel())
}

class MockGiftsCatalogViewModel: GiftsCatalogViewModel {
    @Published private(set) var gifts: [GiftCardDTO]
    
    init() {
        self.gifts = [
            GiftCardDTO(
                title: "15% скидка",
                subtitle: "На первую покупку",
                description: "Почти вся продукция Nike производится сторонними компаниями-подрядчиками  вне территории США (в основном в Азии), сама компания является правообладателем торговых марок, разрабатывает дизайн продукции и владеет сетью магазинов (около 1150 по всему миру), а также торговых центров NikeTown.",
                coverSource: URL(string: "https://avatars.mds.yandex.net/i?id=7b30aafcf011209181cc2e6c179272b5_sr-8453627-images-thumbs&n=13")!,
                storeTitle: "ZARA",
                price: 100
            ),
            GiftCardDTO(
                title: "10% скидка",
                subtitle: "На первую покупку",
                description: "Почти вся продукция Nike производится сторонними компаниями-подрядчиками  вне территории США (в основном в Азии), сама компания является правообладателем торговых марок, разрабатывает дизайн продукции и владеет сетью магазинов (около 1150 по всему миру), а также торговых центров NikeTown.",
                coverSource: URL(string: "https://avatars.mds.yandex.net/i?id=7b30aafcf011209181cc2e6c179272b5_sr-8453627-images-thumbs&n=13")!,
                storeTitle: "ZARA",
                price: 100
            ),
            GiftCardDTO(
                title: "5% скидка",
                subtitle: "На первую покупку",
                description: "Почти вся продукция Nike производится сторонними компаниями-подрядчиками  вне территории США (в основном в Азии), сама компания является правообладателем торговых марок, разрабатывает дизайн продукции и владеет сетью магазинов (около 1150 по всему миру), а также торговых центров NikeTown.",
                coverSource: URL(string: "https://avatars.mds.yandex.net/i?id=7b30aafcf011209181cc2e6c179272b5_sr-8453627-images-thumbs&n=13")!,
                storeTitle: "ZARA",
                price: 100
            ),
            GiftCardDTO(
                title: "10% скидка",
                subtitle: "На заказ через приложение",
                description: "Почти вся продукция Nike производится сторонними компаниями-подрядчиками  вне территории США (в основном в Азии), сама компания является правообладателем торговых марок, разрабатывает дизайн продукции и владеет сетью магазинов (около 1150 по всему миру), а также торговых центров NikeTown.",
                coverSource: URL(string: "https://avatars.mds.yandex.net/i?id=7b30aafcf011209181cc2e6c179272b5_sr-8453627-images-thumbs&n=13")!,
                storeTitle: "DNS",
                price: 100
            ),
            GiftCardDTO(
                title: "5% скидка",
                subtitle: "На заказ через приложение",
                description: "Почти вся продукция Nike производится сторонними компаниями-подрядчиками  вне территории США (в основном в Азии), сама компания является правообладателем торговых марок, разрабатывает дизайн продукции и владеет сетью магазинов (около 1150 по всему миру), а также торговых центров NikeTown.",
                coverSource: URL(string: "https://avatars.mds.yandex.net/i?id=7b30aafcf011209181cc2e6c179272b5_sr-8453627-images-thumbs&n=13")!,
                storeTitle: "DNS",
                price: 100
            ),
            GiftCardDTO(
                title: "2% скидка",
                subtitle: "На первую покупку",
                description: "Почти вся продукция Nike производится сторонними компаниями-подрядчиками  вне территории США (в основном в Азии), сама компания является правообладателем торговых марок, разрабатывает дизайн продукции и владеет сетью магазинов (около 1150 по всему миру), а также торговых центров NikeTown.",
                coverSource: URL(string: "https://avatars.mds.yandex.net/i?id=7b30aafcf011209181cc2e6c179272b5_sr-8453627-images-thumbs&n=13")!,
                storeTitle: "ZARA",
                price: 100
            )
        ]
    }
}
