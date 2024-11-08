//
//  ServicesAllFilesViewModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 06.11.2024.
//

import SwiftUI
import Combine

class ServicesAllFilesViewModel: NewsViewModel {
    @Published private(set) var news: [NewsDTO] = []
    private var cancellables: [AnyCancellable] = []
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    let servicesRepository = DefaultServicesRepository()
    
    init() {
        servicesRepository.getServices()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("done")
                }
            } receiveValue: { [weak self] services in
                self?.news.append(contentsOf: services.toNewsDTO)
                print("Services: \(services)")
            }
            .store(in: &cancellables)
    }
}

extension Array<Service> {
    var toNewsDTO: [NewsDTO] {
        self.map { item in
                .init(title: item.name, subtitle: "", description: "", coverSource: URL(string: item.logoUrl))
        }
    }
}
