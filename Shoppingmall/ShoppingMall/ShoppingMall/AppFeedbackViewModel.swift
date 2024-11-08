//
//  AppFeedbackViewModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 08.11.2024.
//

import SwiftUI
import Combine

class AppFeedbackViewModel: ObservableObject {
    @Published var rating: Int = 0
    @Published var feedbackText: String = ""
    @Published var mobileDeviceId: String = DeviceManager.shared.mobileDeviceId ?? ""
    @Published var isFeedbackSubmitted = false
    @Published var showRatingModal = false
    @Published var showReviewForm = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func submitFeedback() {
        let url = URL(string: "https://skillbox.dev.instadev.net/api/v1/app-feedback")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let feedbackData = [
            "mobile_device_id": mobileDeviceId,
            "text": feedbackText,
            "rating": rating
        ] as [String : Any]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: feedbackData, options: [])
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map { _ in }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Failed to submit feedback: \(error)")
                case .finished:
                    DispatchQueue.main.async {
                        self.isFeedbackSubmitted = true
                    }
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
    
    func handleRatingSubmit() {
        if rating == 5 {
            showRatingModal = true
        } else if rating > 0 {
            showReviewForm = true
        }
    }
}

