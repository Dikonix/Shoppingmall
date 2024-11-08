//
//  HomeView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 13.08.2024.
//

import SwiftUI

struct HomeSectionDTO: Hashable {
    var title: String
    var size: SectionSize = .small
    var items: [HomeItemDTO]
    var destinationView: DestinationView
    
    enum SectionSize {
        case small, large
    }
    
    enum DestinationView {
        case news
        case offers
        case services
        case events
    }
}

struct HomeItemDTO: Hashable {
    var title: String
    var description: String
    var backgroundColor: Color
    var coverImageSource: URL?
    var brightness: Brightness
    
    enum Brightness {
        case light, dark
    }
}
protocol HomeViewModel: ObservableObject {
    var sections: [HomeSectionDTO] { get }
    func getHomeSection()
}

struct HomeView<ViewModel: HomeViewModel & ObservableObject>: View {
    @ObservedObject private var homeViewModel: ViewModel
    
    init(homeViewModel: ViewModel) {
        self.homeViewModel = homeViewModel
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            HomeHeader(
                title: "Shoppingmall",
                greeting: Constants.Text.homeViewGoodAfternoon
            )
            
            if homeViewModel.sections.allSatisfy({ $0.items.isEmpty }) {
                NoDataView(text: Constants.Text.homeViewNoData)
            } else {
                ForEach(homeViewModel.sections, id: \.self) { section in
                    if !section.items.isEmpty {
                        HomeSection(section: section) {
                            HomeCard(item: $0)
                                .frame(height: section.itemHeight)
                        }
                        if (section != homeViewModel.sections.last) {
                            Divider()
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                        }
                    }
                }
            }
        }
        .refreshable {
            homeViewModel.getHomeSection()
        }
    }
}

extension HomeSectionDTO {
    var itemHeight: CGFloat {
        switch size {
            case .large: 160.0
            default: 128.0
        }
    }
}

struct HomeHeader: View {
    let title: String
    let greeting: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.callout)
            Text(greeting)
                .font(.title)
                
        }
        .padding(.vertical, 24)
    }
}

struct HomeSection<Content: View>: View {
    let section: HomeSectionDTO
    let content: (HomeItemDTO) -> Content
    
    var body: some View {
        VStack {
            SectionHeader(title: section.title, destinationView: section.destinationView)
            
            HomeCarousel(items: section.items) { item in
                content(item)
            }
        }
    }
}

struct SectionHeader: View {
    let title: String
    let destinationView: HomeSectionDTO.DestinationView
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
            Spacer()
            NavigationLink(destination: {
                switch destinationView {
                case .news:
                    NewsView(viewModel: NewsAllFilesViewModel(), title: title)
                case .offers:
                    NewsView(viewModel: OffersAllFilesViewModel(), title: title)
                case .services:
                    NewsView(viewModel: ServicesAllFilesViewModel(), title: title)
                case .events:
                    NewsView(viewModel: EventsAllFilesViewModel(), title: title)
                }
            }) {
                Text("Все")
            }
        }
        .padding(.horizontal, 16)
    }
}

struct HomeCarousel<Content: View>: View {
    let items: [HomeItemDTO]
    let content: (HomeItemDTO) -> Content
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(items, id: \.self) { item in
                    content(item)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct HomeCard: View {
    let item: HomeItemDTO
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: item.coverImageSource) { image in
                image
                    .resizable(resizingMode: .stretch)
            } placeholder: {
                Rectangle()
                    .fill(item.backgroundColor)
            }
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                if !item.description.isEmpty {
                    Text(item.description)
                        .font(.subheadline)
                }
            }
            .foregroundStyle(item.contentStyle)
            .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .aspectRatio(CGSize(width: 2, height: 1), contentMode: .fill)
    }
}

extension HomeItemDTO {
    var contentStyle: some ShapeStyle {
        switch brightness {
            case .dark: return .white
            case .light: return .black
        }
    }
}

#Preview {
    HomeView(homeViewModel: MockHomeViewModel())
}

class MockHomeViewModel: HomeViewModel {
    @Published private(set) var sections: [HomeSectionDTO] = []
    
    init() {
        getHomeSection()
    }
    
    func getHomeSection() {
        self.sections = [
            HomeSectionDTO(
                title: "Новости",
                size: .large,
                items: [
                    HomeItemDTO(
                        title: "Black Friday",
                        description: "скидки до 70%",
                        backgroundColor: Color.black,
                        coverImageSource: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRP5Yk-9uapAB-NMnkxTdTcJQZn0S5PfScR5RV33XLXpGtlbQ0bmaxH8Wgw2OYFZel6MtA&usqp=CAU")!,
                        brightness: .dark
                    ),
                    HomeItemDTO(
                        title: "Зимняя распродажа",
                        description: "скидки до 25%",
                        backgroundColor: Color.gray,
                        coverImageSource: URL(string: "https://avatars.mds.yandex.net/i?id=af2bb360823154405977499f38548b99_sr-12495681-images-thumbs&n=13")!,
                        brightness: .dark
                    )
                ], destinationView: .news
            ),
            HomeSectionDTO(
                title: "Новые предложения",
                items: [
                    HomeItemDTO(
                        title: "Розыгрыш призов",
                        description: "более 100 призов",
                        backgroundColor: Color.blue,
                        brightness: .dark
                    ),
                    HomeItemDTO(
                        title: "Скидка на доставку",
                        description: "При заказе от 1500",
                        backgroundColor: Color.gray,
                        coverImageSource: URL(string: "https://bogatyr.club/uploads/posts/2024-03/thumbs/1710344164_bogatyr-club-ncj2-p-fon-dlya-kursovoi-prezentatsii-2.jpg")!,
                        brightness: .light
                    )
                ], destinationView: .offers
            ),
            HomeSectionDTO(
                title: "Полезная информация",
                items: [
                    HomeItemDTO(
                        title: "Переработка",
                        description: "разбираем полки",
                        backgroundColor: Color.white,
                        brightness: .light
                    ),
                    HomeItemDTO(
                        title: "Ухаживаем за волосами",
                        description: "с Organic Kitchen",
                        backgroundColor: Color.orange,
                        brightness: .dark
                    )
                ], destinationView: .services
            ),
            HomeSectionDTO(
                title: "Мероприятия",
                items: [
                    HomeItemDTO(
                        title: "Мастер-классы",
                        description: "для детей от 6 лет",
                        backgroundColor: Color.black,
                        coverImageSource: URL(string: "https://avatars.mds.yandex.net/i?id=f87edad388aee0e0ea215bd7e9ad12d9_sr-8235455-images-thumbs&n=13")!,
                        brightness: .dark
                    ),
                    HomeItemDTO(
                        title:"Выходные с Shoppingmall",
                        description: "для всей семьи",
                        backgroundColor: Color.blue,
                        brightness: .dark
                    )
                ], destinationView: .events
            ),
        ]
    }
}
