//
//  NewsView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 29.10.2024.
//

import SwiftUI

struct MenuNewsDTO: Hashable, Identifiable {
    let id: UUID
    let title: String
    let type: String
    let startDate: String
    let endDate: String
    let description: String
    let coverSource: URL
}

protocol MenuNewsViewModel: ObservableObject {
    var title: String { get }
    var news: [MenuNewsDTO] { get }
    func getNews()
}

enum NewsType: String {
    case news = "news"
    case promotion = "promotion"
}

struct MenuNewsView<ViewModel: MenuNewsViewModel>: View {
    @State private var selectedNews: MenuNewsDTO?
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            if viewModel.news.isEmpty {
                NoDataView(text: Constants.Text.homeViewNoData)
            } else {
                ForEach(viewModel.news, id: \.self) { news in
                    MenuNewsCard(news: news)
                        .onTapGesture {
                            selectedNews = news
                        }
                }
                .padding()
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.title)
        .refreshable {
            viewModel.getNews()
        }
        .sheet(item: $selectedNews, onDismiss: {
            selectedNews = nil
        }) { selectedNews in
            if selectedNews.type == NewsType.news.rawValue {
                NewsDetailsView(viewModel: NewsDetailsViewModel(newsId: selectedNews.id))
            } else {
                MenuPromotionView(viewModel: MenuPromotionViewModel(promotionId: selectedNews.id))
            }
        }
    }
}

private struct MenuNewsCard: View {
    let news: MenuNewsDTO
    
    var body: some View {
        ZStack {
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
                if !news.startDate.isEmpty && !news.endDate.isEmpty {
                    Text("\(Services.shared.formatDate(from: news.startDate)) - \(Services.shared.formatDate(from: news.endDate))")
                        .font(.subheadline)
                }
            }
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        MenuNewsView(viewModel: MockMenuNewsViewModel())
    }
}

class MockMenuNewsViewModel: MenuNewsViewModel {
    let title: String = "Новости и акции"
    @Published var news: [MenuNewsDTO] = []
    
    init() {
        getNews()
    }
    
    func getNews() {
        self.news = [
            MenuNewsDTO(
                id: UUID(),
                title: "Серия косметики MySkin",
                type: "news",
                startDate: "c 16 ноября",
                endDate: "",
                description: "Почти вся продукция Nike производится сторонними компаниями-подрядчиками вне территории США (в основном в Азии), сама компания является правообладателем торговых марок, разрабатывает дизайн продукции и владеет сетью магазинов (около 1150 по всему миру), а также торговых центров NikeTown.",
                coverSource: URL(string: "https://avatars.mds.yandex.net/i?id=7b30aafcf011209181cc2e6c179272b5_sr-8453627-images-thumbs&n=13")!
            ),
            MenuNewsDTO(
                id: UUID(),
                title: "Выиграйте 1 000 000 за покупки в Familia",
                type: "promotion",
                startDate: "16 ноября",
                endDate: "- 30 января",
                description: "Почти вся продукция Nike производится сторонними компаниями-подрядчиками вне территории США (в основном в Азии), сама компания является правообладателем торговых марок, разрабатывает дизайн продукции и владеет сетью магазинов (около 1150 по всему миру), а также торговых центров NikeTown.",
                coverSource: URL(string: "https://avatars.mds.yandex.net/i?id=7b30aafcf011209181cc2e6c179272b5_sr-8453627-images-thumbs&n=13")!
            )
        ]
    }
}
