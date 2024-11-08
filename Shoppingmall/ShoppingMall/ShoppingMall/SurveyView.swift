//
//  SurveyView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import SwiftUI

struct SurveyView: View {
    @AppStorage("_shouldShowOnOnboarding") var shouldShowOnboarding: Bool = true
    @StateObject private var viewModel: SurveyViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var shouldShowHome = false
    
    init(mobileDeviceID: String = DeviceManager.shared.mobileDeviceId ?? "",
         token: String = UserDefaults.standard.string(forKey: "token") ?? "") {
        _viewModel = StateObject(wrappedValue: SurveyViewModel(mobileDeviceID: mobileDeviceID, token: token))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text(Constants.Text.surveyViewFirstQuestion)
                    .font(.headline)
               
                Spacer()
                
                DatePicker("", selection: $viewModel.surveyModel.dateOfBirth, displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(.compact)
                    .padding(.horizontal)
            }

            Text(Constants.Text.surveyViewSecondQuestion)
                .font(.headline)
            
            Picker(Constants.Text.surveyViewSecondQuestion, selection: $viewModel.surveyModel.hasKids) {
                Text(Constants.Text.surveyViewYes).tag(true)
                Text(Constants.Text.surveyViewNo).tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            Button(action: {
                viewModel.submitSurvey()
            }) {
                Text(Constants.Text.surveyViewAnswerButtonName)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(viewModel.isFormValid ? Color(uiColor: Constants.Colors.purple ?? .purple) : Color.gray)
                    .cornerRadius(8)
            }
            .disabled(!viewModel.isFormValid)
            .padding(.top, 20)
            
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            }
            
            if let earnedPoints = viewModel.earnedPoints {
                Text(Constants.Text.surveyViewFirstPartOfPoints + " \(earnedPoints) " + Constants.Text.surveyViewSecondPartOfPoints)
                    .foregroundColor(.green)
                    .padding()
            }
        }
        .navigationTitle(Constants.Text.surveyViewTitle)
        .navigationBarBackButtonHidden(true)
        .padding()
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: Text(Constants.Text.referralCodeViewAlertTitle),
                  message: Text(alertItem.message),
                  dismissButton: .default(Text(Constants.Text.referralCodeViewAlertButtonTitle), action: {
                    shouldShowHome = true
                    AuthManager.isAuthenticated = true
                    presentationMode.wrappedValue.dismiss()
            }))
        }
        .onChange(of: viewModel.isSurveyCompleted) {
            if viewModel.isSurveyCompleted {
                shouldShowHome = true
                AuthManager.isAuthenticated = true
                presentationMode.wrappedValue.dismiss()
            }
        }
        
        .onChange(of: shouldShowHome) {
            if shouldShowHome {
                shouldShowOnboarding = false
                AuthManager.isAuthenticated = true
                presentationMode.wrappedValue.dismiss()
            }
        }
        
        Spacer()
    }
}

#Preview {
    SurveyView()
}
