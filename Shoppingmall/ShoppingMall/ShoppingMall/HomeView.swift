//
//  HomeView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 13.08.2024.
//

import SwiftUI

struct HomeView: View {
    @State private var newsSliderData: [NewsCardData] = []
    @State private var newOffersData: [OfferCardData] = []
    @State private var usefulInfoData: [ShopCardData] = []
    @State private var eventsData: [EventCardData] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(uiImage: UIImage.shoppingmall)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 312, height: 18.24)
                    .padding(8)
                Text(Constants.Text.homeViewGoodAfternoon)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                
                if !newsSliderData.isEmpty {
                    HomeBlockView(title: Constants.Text.homeViewNews, frameWidth: 308, frameHeight: 167, cards: newsSliderData.map { $0.toCard() }, onSeeAllTap: {
                        
                    })
                }
                
                if !newOffersData.isEmpty {
                    HomeBlockView(title: Constants.Text.homeViewNewOffers, frameWidth: 227, frameHeight: 127, cards: newOffersData.map { $0.toCard() }, onSeeAllTap: {
                       
                    })
                }
                
                if !usefulInfoData.isEmpty {
                    HomeBlockView(title: Constants.Text.homeViewUsefulInformation, frameWidth: 227, frameHeight: 127, cards: usefulInfoData.map { $0.toCard() }, onSeeAllTap: {
                        
                    })
                }
                
                if !eventsData.isEmpty {
                    HomeBlockView(title: Constants.Text.homeViewEvents, frameWidth: 227, frameHeight: 127, cards: eventsData.map { $0.toCard() }, onSeeAllTap: {
                       
                    })
                }
            }
            .padding()
        }
        .onAppear {
            fetchData()
        }
    }
    
    private func fetchData() {
        fetchNewsSliderData()
        fetchNewOffersData()
        fetchUsefulInfoData()
        fetchEventsData()
    }
    
    private func fetchNewsSliderData() {
        let urlString = "https://skillbox.dev.instadev.net/api/v1/news/with/promotions-and-event"
        let queryItems = [
            URLQueryItem(name: "on_main", value: "true")
        ]
        
        guard var urlComponents = URLComponents(string: urlString) else { return }
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("News JSON: \(jsonString)")
            }
            
            if let decodedResponse = try? JSONDecoder().decode([NewsCardData].self, from: data) {
                DispatchQueue.main.async {
                    self.newsSliderData = decodedResponse
                }
            }
        }.resume()
    }
    
    private func fetchNewOffersData() {
        let urlString = "https://skillbox.dev.instadev.net/api/v1/offers"
        let queryItems = [
            URLQueryItem(name: "on_home", value: "true")
        ]
        
        guard var urlComponents = URLComponents(string: urlString) else { return }
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Offers JSON: \(jsonString)")
            }
            
            if let decodedResponse = try? JSONDecoder().decode([OfferCardData].self, from: data) {
                DispatchQueue.main.async {
                    self.newOffersData = decodedResponse
                }
            }
        }.resume()
    }
    
    private func fetchUsefulInfoData() {
        let urlString = "https://skillbox.dev.instadev.net/api/v1/shops/category/slug/services"
        let queryItems = [
            URLQueryItem(name: "on_home", value: "true")
        ]
        
        guard var urlComponents = URLComponents(string: urlString) else { return }
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            
            if let decodedResponse = try? JSONDecoder().decode([ShopCardData].self, from: data) {
                DispatchQueue.main.async {
                    self.usefulInfoData = decodedResponse
                }
            }
        }.resume()
    }
    
    private func fetchEventsData() {
        let urlString = "https://skillbox.dev.instadev.net/api/v1/events"
        let queryItems = [
            URLQueryItem(name: "on_home", value: "true")
        ]
        
        guard var urlComponents = URLComponents(string: urlString) else { return }
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            
            if let decodedResponse = try? JSONDecoder().decode([EventCardData].self, from: data) {
                DispatchQueue.main.async {
                    self.eventsData = decodedResponse
                }
            }
        }.resume()
    }
}

struct HomeBlockView: View {
    let title: String
    let frameWidth: CGFloat
    let frameHeight: CGFloat
    let cards: [CardData]
    let onSeeAllTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.title3)
                Spacer()
                Button(action: onSeeAllTap) {
                    Text(Constants.Text.homeViewTextAllButton)
                        .foregroundColor(.blue)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(cards) { card in
                        CardView(card: card, frameWidth: frameWidth, frameHeight: frameHeight)
                    }
                }
            }
        }
    }
}

struct CardView: View {
    let card: CardData
    let frameWidth: CGFloat
    let frameHeight: CGFloat
    
    var body: some View {
        ZStack {
            if let url = URL(string: card.imageUrl ?? "") {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                } placeholder: {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(card.backgroundColor)
                }
            }
            VStack(alignment: .leading) {
                Spacer()
                Text(card.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.bottom, 15)
                if let subtitle = card.subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                }
            }
        }
        .frame(width: frameWidth, height: frameHeight)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct CardData: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String?
    let imageUrl: String?
    let backgroundColor: Color
}

struct NewsCardData: Identifiable, Decodable {
    let id: String
    let title: String
    let logo_url: String?
    
    func toCard() -> CardData {
        return CardData(title: title, subtitle: "", imageUrl: logo_url, backgroundColor: Color(uiColor: Constants.Colors.coral ?? .orange))
    }
}

struct OfferCardData: Identifiable, Decodable {
    let id: String
    let name: String
    let description: String?
    let image: String?
    
    func toCard() -> CardData {
        return CardData(title: name, subtitle: description, imageUrl: image, backgroundColor: Color(uiColor: Constants.Colors.purple ?? .purple))
    }
}

struct ShopCardData: Identifiable, Decodable {
    let id: String
    let name: String
    let logo_url: String?
    
    func toCard() -> CardData {
        return CardData(title: name, subtitle: "", imageUrl: logo_url, backgroundColor: Color(uiColor: Constants.Colors.coral ?? .orange))
    }
}

struct EventCardData: Identifiable, Decodable {
    let id: String
    let title: String
    let logo_url: String?
    
    func toCard() -> CardData {
        return CardData(title: title, subtitle: "", imageUrl: logo_url, backgroundColor: Color(uiColor: Constants.Colors.purple ?? .purple))
    }
}

#Preview {
    HomeView()
}
