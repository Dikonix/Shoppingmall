//
//  DeviceManager.swift
//  ShoppingMall
//
//  Created by Diana Brik on 15.08.2024.
//

import SwiftUI
import Combine

class DeviceManager {
    static let shared = DeviceManager()
    private let userDefaults = UserDefaults.standard
    private let mobileDeviceIdKey = "mobileDeviceId"
    private var cancellables = Set<AnyCancellable>()

    private init() {}

    var mobileDeviceId: String? {
        return userDefaults.string(forKey: mobileDeviceIdKey)
    }

    func registerDeviceIfNeeded() {
        guard mobileDeviceId == nil else { return }

        let installAppTimestamp = Int(Date().timeIntervalSince1970)
        let os = "iOS"
        let versionOS = UIDevice.current.systemVersion
        let model = UIDevice.current.model

        let urlString = "https://skillbox.dev.instadev.net/api/v1/mobile-device"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "install_app": installAppTimestamp,
            "os": os,
            "version_os": versionOS,
            "model": model
        ]

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [String: String].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { response in
                if let mobileDeviceId = response["id"] {
                    self.userDefaults.set(mobileDeviceId, forKey: self.mobileDeviceIdKey)
                    print("Device registered with mobileDeviceId: \(mobileDeviceId)")
                }
            })
            .store(in: &cancellables)
    }
}
