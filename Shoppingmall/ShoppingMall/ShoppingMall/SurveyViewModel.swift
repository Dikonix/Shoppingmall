//
//  SurveyViewModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import SwiftUI
import Combine

class SurveyViewModel: ObservableObject {
    @Published var surveyModel = SurveyModel()
    @Published var isSurveyCompleted = false
    @Published var isLoading = false
    @Published var alertItem: AlertItem?
    @Published var earnedPoints: Int? = nil
    
    private let mobileDeviceID: String
    private let token: String
    private var cancellables = Set<AnyCancellable>()
    
    init(mobileDeviceID: String, token: String) {
        self.mobileDeviceID = mobileDeviceID
        self.token = token
    }
    
    var isFormValid: Bool {
        surveyModel.dateOfBirth != Date()
    }
    
    func submitSurvey() {
        guard isFormValid else {
            alertItem = AlertItem(message: Constants.Text.surveyViewModelAlertWarning)
            return
        }
        
        isLoading = true
        let userUpdateURL = URL(string: "https://skillbox.dev.instadev.net/api/v1/mobile-users/\(mobileDeviceID)")!
        var request = URLRequest(url: userUpdateURL)
        request.httpMethod = "PUT"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "date_birth": Int(surveyModel.dateOfBirth.timeIntervalSince1970),
            "have_kids": surveyModel.hasKids
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { response in
                guard let httpResponse = response.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return response.data
            }
            .flatMap { _ in
                self.fetchEarnedPoints()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(_) = completion {
                    self?.alertItem = AlertItem(message: Constants.Text.surveyViewModelAlertError)
                }
            }, receiveValue: { [weak self] points in
                self?.earnedPoints = points
                self?.isSurveyCompleted = true
            })
            .store(in: &cancellables)
    }
    
    private func fetchEarnedPoints() -> AnyPublisher<Int, Error> {
        let surveyURL = URL(string: "https://skillbox.dev.instadev.net/api/v1/mobile-users/\(mobileDeviceID)/survey")!
        var request = URLRequest(url: surveyURL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { response in
                guard let httpResponse = response.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return response.data
            }
            .decode(type: [SurveyResponse].self, decoder: JSONDecoder())
            .map { responses in
                responses.first?.changeBalance ?? 0
            }
            .eraseToAnyPublisher()
    }
}

