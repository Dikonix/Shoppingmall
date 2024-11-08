//
//  ProfileModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import Foundation
import Combine

struct ProfileData: Decodable {
    let id: UUID
    let phone: String
    let name: String
    let email: String
}

protocol ProfileDataRepository {
    func getUserProfile(mobileUserID: String) -> AnyPublisher<ProfileData, Never>
}

class DefaultProfileDataRepository: ProfileDataRepository {
    func getUserProfile(mobileUserID: String) -> AnyPublisher<ProfileData, Never> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: "https://skillbox.dev.instadev.net/api/v1/mobile-users/\(mobileUserID)")!)
            .map { $0.data }
            .decode(type: ProfileData.self, decoder: JSONDecoder())
            .replaceError(with: ProfileData(id: UUID(), phone: "", name: "", email: ""))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
