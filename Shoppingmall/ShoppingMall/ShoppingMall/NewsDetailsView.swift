//
//  NewsDetailsView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 02.11.2024.
//

import SwiftUI

struct NewsDetailsDTO: Hashable, Identifiable {
    let id: UUID
    let title: String
    let publishedDate: String
    let description: String
    let coverSource: URL?
}

protocol NewsDetailViewModel: ObservableObject {
    var newsDetails: NewsDetailsDTO? { get }
}

struct NewsDetailsView<ViewModel: NewsDetailViewModel>: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            if let newsDetails = viewModel.newsDetails {
                if newsDetails.title.isEmpty {
                    NoDataView(text: Constants.Text.newsViewNoDataRepeatLater)
                } else {
                    VStack(alignment: .leading) {
                        ZStack(alignment: .topTrailing) {
                            AsyncImage(url: newsDetails.coverSource) { image in
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
                        
                        Text(newsDetails.title)
                            .font(.largeTitle)
                        
                        Text("\(Services.shared.formatDate(from: newsDetails.publishedDate))")
                            .font(.title)
                        
                        Divider()
                        
                        Text(newsDetails.description)
                            .font(.body)
                    }
                    .padding(32)
                }
            }
        }
    }
}
