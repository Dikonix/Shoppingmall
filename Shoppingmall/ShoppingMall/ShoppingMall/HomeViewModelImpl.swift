//
//  HomeViewModelImpl.swift
//  ShoppingMall
//
//  Created by Diana Brik on 29.10.2024.
//

import SwiftUI
import Combine

class HomeViewModelImpl: HomeViewModel {
    @Published private(set) var sections: [HomeSectionDTO] = []
    private var cancellables: [AnyCancellable] = []
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    let newsAndEventsRepository = DefaultNewsAndEventsRepository()
    let offersRepository = DefaultOffersRepository()
    let servicesRepository = DefaultServicesRepository()
    let eventsRepository = DefaultEventsRepository()
    
    init() {
        getHomeSection()
    }
    
    func getHomeSection() {
        newsAndEventsRepository.getNewsAndEvents()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("done")
                }
            } receiveValue: { [weak self] newsAndEvent in
                self?.sections.append(contentsOf: newsAndEvent.toHomeSectionDTO)
                print("News: \(newsAndEvent)")
            }
            .store(in: &cancellables)
        offersRepository.getOffers()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("done")
                }
            } receiveValue: { [weak self] offers in
                self?.sections.append(contentsOf: offers.toHomeSectionDTO)
                print("Offers: \(offers)")
            }
            .store(in: &cancellables)
        servicesRepository.getServices()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("done")
                }
            } receiveValue: { [weak self] services in
                self?.sections.append(contentsOf: services.toHomeSectionDTO)
                print("Services: \(services)")
            }
            .store(in: &cancellables)
        eventsRepository.getEvents()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("done")
                }
            } receiveValue: { [weak self] events in
                self?.sections.append(contentsOf: events.toHomeSectionDTO)
                print("Events: \(events)")
            }
            .store(in: &cancellables)
    }
}

extension Array<NewsAndEvent> {
    var toHomeSectionDTO: [HomeSectionDTO] {
        [
            .init(title: Constants.Text.homeViewNews, items: self.map { item in .init(title: item.title, description: "", backgroundColor: Color(uiColor: Constants.Colors.purple ?? .purple), coverImageSource: URL(string: item.logoUrl), brightness: .dark)}, destinationView: .news)
        ]
    }
}

extension Array<Offer> {
    var toHomeSectionDTO: [HomeSectionDTO] {
        [
            .init(title: Constants.Text.homeViewNewOffers, items: self.map { item in .init(title: item.name, description: item.description, backgroundColor: Color(uiColor: Constants.Colors.coral ?? .systemPink), coverImageSource: URL(string: item.image), brightness: .light)}, destinationView: .offers)
        ]
    }
}

extension Array<Service> {
    var toHomeSectionDTO: [HomeSectionDTO] {
        [
            .init(title: Constants.Text.homeViewUsefulInformation, items: self.map { item in .init(title: item.name, description: "", backgroundColor: Color(uiColor: Constants.Colors.purple ?? .purple), coverImageSource: URL(string: item.logoUrl), brightness: .dark)}, destinationView: .services)
        ]
    }
}

extension Array<Event> {
    var toHomeSectionDTO: [HomeSectionDTO] {
        [
            .init(title: Constants.Text.homeViewEvents, items: self.map { item in .init(title: item.title, description: item.date, backgroundColor: Color(uiColor: Constants.Colors.coral ?? .systemPink), coverImageSource: URL(string: item.logoUrl), brightness: .light)}, destinationView: .events)
        ]
    }
}

