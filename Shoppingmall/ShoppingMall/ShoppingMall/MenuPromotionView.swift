//
//  MenuPromotionView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 03.11.2024.
//

import SwiftUI

struct PromotionDTO: Hashable, Identifiable {
    let id: UUID
    let title: String
    let startDate: String
    let endDate: String
    let description: String
    let coverSource: URL?
}

protocol MenuPromotionDetailViewModel: ObservableObject {
    var promotion: PromotionDTO? { get }
}

struct MenuPromotionView<ViewModel: MenuPromotionDetailViewModel>: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            if let promotion = viewModel.promotion {
                if !promotion.title.isEmpty {
                    VStack(alignment: .leading) {
                        ZStack(alignment: .topTrailing) {
                            AsyncImage(url: promotion.coverSource) { image in
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
                        
                        Text(promotion.title)
                            .font(.largeTitle)
                        
                        Text("\(Services.shared.formatDate(from: promotion.startDate)) - \(Services.shared.formatDate(from: promotion.endDate))")
                            .font(.title)
                        
                        Divider()
                        
                        Text(promotion.description)
                            .font(.body)
                    }
                    .padding(32)
                } else {
                    NoDataView(text: Constants.Text.newsViewNoDataRepeatLater)
                }
            }
        }
    }
}

