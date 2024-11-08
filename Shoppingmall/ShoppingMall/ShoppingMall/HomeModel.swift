//
//  HomeModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 29.10.2024.
//

import SwiftUI
import Combine

struct NewsAndEvent: Identifiable, Decodable {
    let id: UUID
    let type: String
    let title: String
    let logoUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case title
        case logoUrl = "logo_url"
    }
}

protocol NewsAndEventsRepository {
    func getNewsAndEvents() -> AnyPublisher<[NewsAndEvent], Never>
}

class DefaultNewsAndEventsRepository: NewsAndEventsRepository {
    func getNewsAndEvents() -> AnyPublisher<[NewsAndEvent], Never> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: "https://skillbox.dev.instadev.net/api/v1/news/with/promotions-and-event?on_main=true")!)
            .map { $0.data }
            .decode(type: [NewsAndEvent].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct Offer: Identifiable, Decodable {
    let id: UUID
    let name: String
    let description: String
    let image: String
}

protocol OffersRepository {
    func getOffers() -> AnyPublisher<[Offer], Never>
}

class DefaultOffersRepository: OffersRepository, ObservableObject {
    func getOffers() -> AnyPublisher<[Offer], Never> {
        return URLSession.shared.dataTaskPublisher(for: URL(string:
            "https://skillbox.dev.instadev.net/api/v1/offers?on_home=true")!)
            .map { $0.data }
            .decode(type: [Offer].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct Service: Identifiable, Decodable {
    let id: UUID
    let name: String
    let logoUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logoUrl = "logo_url"
    }
}

protocol ServicesRepository {
    func getServices() -> AnyPublisher<[Service], Never>
}

class DefaultServicesRepository: ServicesRepository, ObservableObject {
    func getServices() -> AnyPublisher<[Service], Never> {
        return URLSession.shared.dataTaskPublisher(for: URL(string:
            "https://skillbox.dev.instadev.net/api/v1/shops/category/slug/services?on_home=true")!)
            .map { $0.data }
            .decode(type: [Service].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct Event: Identifiable, Decodable {
    let id: UUID
    let title: String
    let logoUrl: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case logoUrl = "logo_url"
        case date
    }
}

protocol EventsRepository {
    func getEvents() -> AnyPublisher<[Event], Never>
}

class DefaultEventsRepository: EventsRepository, ObservableObject {
    func getEvents() -> AnyPublisher<[Event], Never> {
        return URLSession.shared.dataTaskPublisher(for: URL(string:
            "https://skillbox.dev.instadev.net/api/v1/events?on_home=true")!)
            .map { $0.data }
            .decode(type: [Event].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
