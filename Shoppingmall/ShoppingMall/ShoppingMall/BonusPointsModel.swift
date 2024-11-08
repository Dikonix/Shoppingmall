//
//  BonusPointsModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import Foundation
import Combine

class BonusPointsModel {
    func addRegisterTransaction(for userID: String) -> AnyPublisher<Void, Error> {
        let urlString = "https://skillbox.dev.instadev.net/api/v1/mobile-users/\(userID)/add-register"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: NSError(domain: "Invalid URL", code: 400, userInfo: nil))
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { _ in }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
