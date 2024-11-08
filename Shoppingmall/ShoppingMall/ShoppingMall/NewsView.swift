//
//  NewsView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 06.11.2024.
//

import SwiftUI

struct NewsDTO: Hashable {
    let title: String
    let subtitle: String
    let description: String
    let coverSource: URL?
}

protocol NewsViewModel: ObservableObject {
    var news: [NewsDTO] { get }
}

struct NewsView<ViewModel: NewsViewModel>: View {
    @State private var selectedNews: NewsDTO?
    @State private var showingCredits = false
    @ObservedObject private var viewModel: ViewModel
    @State private var title: String
    
    init(viewModel: ViewModel, title: String) {
        self.viewModel = viewModel
        self.title = title
    }
    
    var body: some View {
        ScrollView {
            if viewModel.news.isEmpty {
                NoDataView(text: Constants.Text.newsViewNoDataRepeatLater)
            } else {
                ForEach(viewModel.news, id: \.self) { news in
                    NewsCard(news: news)
                        .onTapGesture {
                            selectedNews = news
                            showingCredits = true
                        }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(title)
        .sheet(isPresented: $showingCredits, content: {
            NewsDetails(news: selectedNews ?? NewsDTO(title: "", subtitle: "", description: "", coverSource: URL(string: "https://avatars.mds.yandex.net/i?id=7b30aafcf011209181cc2e6c179272b5_sr-8453627-images-thumbs&n=13")))
        })
    }
}

private struct NewsCard: View {
    let news: NewsDTO
    
    var body: some View {
        ZStack {
            if news.title.isEmpty {
                NoDataView(text: Constants.Text.newsViewNoDataRepeatLater)
            } else {
                Rectangle()
                    .fill(Color(red: 0.98, green: 0.98, blue: 0.95))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                VStack(alignment: .leading) {
                    AsyncImage(url: news.coverSource) { image in
                        image.resizable()
                    } placeholder: {
                        Rectangle()
                            .fill(Color(red: 0.98, green: 0.98, blue: 0.95))
                    }
                    .aspectRatio(CGSize(width: 2, height: 1), contentMode: .fill)
                    .frame(height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Text(news.title)
                        .font(.headline)
                    
                    Text(news.subtitle)
                        .font(.subheadline)
                }
                .padding()
            }
        }
    }
}

private struct NewsDetails: View {
    let news: NewsDTO
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            if news.title.isEmpty {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "xmark.square.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .padding()
                        .onTapGesture {
                            dismiss()
                        }
                    NoDataView(text: Constants.Text.newsViewNoDataRepeatLater)
                        .padding()
                }
            } else {
                VStack(alignment: .leading) {
                    ZStack(alignment: .topTrailing) {
                        AsyncImage(url: news.coverSource) { image in
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
                    
                    Text(news.title)
                        .font(.largeTitle)
                    
                    Text(news.subtitle)
                        .font(.title)
                    
                    Divider()
                    
                    Text(news.description)
                        .font(.body)
                }
                .padding(32)
            }
        }
    }
}

#Preview {
    NavigationStack {
        NewsView(viewModel: MockNewsViewModel(), title: "Новости и акции")
    }
}

class MockNewsViewModel: NewsViewModel {
    @Published var news: [NewsDTO]
    
    init() {
        self.news = [
            NewsDTO(
                title: "Серия косметики MySkin",
                subtitle: "c 16 ноября",
                description: "Почти вся продукция Nike производится сторонними компаниями-подрядчиками вне территории США (в основном в Азии), сама компания является правообладателем торговых марок, разрабатывает дизайн продукции и владеет сетью магазинов (около 1150 по всему миру), а также торговых центров NikeTown.",
                coverSource: URL(string: "https://avatars.mds.yandex.net/i?id=7b30aafcf011209181cc2e6c179272b5_sr-8453627-images-thumbs&n=13")!
            ),
            NewsDTO(
                title: "Выиграйте 1 000 000 за покупки в Familia",
                subtitle: "16 ноября - 30 января",
                description: "Почти вся продукция Nike производится сторонними компаниями-подрядчиками вне территории США (в основном в Азии), сама компания является правообладателем торговых марок, разрабатывает дизайн продукции и владеет сетью магазинов (около 1150 по всему миру), а также торговых центров NikeTown.",
                coverSource: URL(string: "https://avatars.mds.yandex.net/i?id=7b30aafcf011209181cc2e6c179272b5_sr-8453627-images-thumbs&n=13")!
            )
        ]
    }
}
