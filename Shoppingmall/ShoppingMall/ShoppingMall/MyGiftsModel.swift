//
//  MyGiftsModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import SwiftUI
import Combine

struct MyGifts: Identifiable, Decodable {
    let id: UUID
    //В запроске никаких данных нет, но в макете отображается информация, у offers такие данные есть
    let name: String
    let description: String
    let disclaimer: String
}

protocol MyGiftsRepository {
    func getMyGifts(mobileDeviceId: String) -> AnyPublisher<[MyGifts], Never>
}

class DefaultMyGiftsRepository: MyGiftsRepository {
    func getMyGifts(mobileDeviceId: String) -> AnyPublisher<[MyGifts], Never> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: "https://skillbox.dev.instadev.net/api/v1/mobile-users/\(mobileDeviceId)/offers")!)
            .map { $0.data }
            .decode(type: [MyGifts].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
