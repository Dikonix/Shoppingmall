//
//  LogoutModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import Foundation
import Combine

struct LogoutRequest: Encodable {
    let mobileDeviceId: String
    let token: String
}

struct LogoutResponse: Decodable {
    let success: Bool
    let message: String
}

protocol LogoutService {
    func logout(mobileDeviceId: String, token: String) -> AnyPublisher<LogoutResponse, Error>
}

class DefaultLogoutService: LogoutService {
    func logout(mobileDeviceId: String, token: String) -> AnyPublisher<LogoutResponse, Error> {
        guard let url = URL(string: "https://skillbox.dev.instadev.net/api/v1/mobile-users/\(mobileDeviceId)/logout") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let requestBody = LogoutRequest(mobileDeviceId: mobileDeviceId, token: token)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(requestBody)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: LogoutResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
