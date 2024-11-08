//
//  EventsAllFilesViewModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 06.11.2024.
//

import SwiftUI
import Combine

class EventsAllFilesViewModel: NewsViewModel {
    @Published private(set) var news: [NewsDTO] = []
    private var cancellables: [AnyCancellable] = []
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    let eventsRepository = DefaultEventsRepository()
    
    init() {
        eventsRepository.getEvents()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("done")
                }
            } receiveValue: { [weak self] events in
                self?.news.append(contentsOf: events.toNewsDTO)
                print("Events: \(events)")
            }
            .store(in: &cancellables)
    }
}

extension Array<Event> {
    var toNewsDTO: [NewsDTO] {
        self.map { item in
                .init(title: item.title, subtitle: "", description: "", coverSource: URL(string: item.logoUrl))
        }
    }
}
