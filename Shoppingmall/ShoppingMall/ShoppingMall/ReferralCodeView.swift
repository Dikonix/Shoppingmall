//
//  ReferralCodeView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import SwiftUI

struct ReferralCodeView: View {
    @StateObject private var viewModel: ReferralCodeViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showSurvey = false
    
    init(mobileDeviceID: String = DeviceManager.shared.mobileDeviceId ?? "",
         token: String = UserDefaults.standard.string(forKey: "token") ?? "") {
        _viewModel = StateObject(wrappedValue: ReferralCodeViewModel(mobileDeviceID: mobileDeviceID, token: token))
    }
    
    var body: some View {
        VStack {
            Text(Constants.Text.referralCodeViewEnterPromocode)
                .font(.headline)
                .padding()
            
            TextField(Constants.Text.referralCodeViewPromocode, text: $viewModel.promoCode)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.default)
            
            if let alertItem = viewModel.alertItem {
                Text(alertItem.message)
                    .foregroundColor(alertItem.message == Constants.Text.referralCodeViewModelInvalidAlertMessage ? .red : .green)
                    .padding()
            }
            
            Button(action: {
                viewModel.validatePromoCode()
            }) {
                Text(Constants.Text.referralCodeViewGetPointsButtonName)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isPromoCodeValid ? Color(uiColor: Constants.Colors.purple ?? .purple) : Color.gray)
                    .cornerRadius(8)
            }
            .disabled(!viewModel.isPromoCodeValid)
            .padding()
            
            Button(action: {
                showSurvey = true
            }) {
                Text(Constants.Text.referralCodeViewNoPromocodeButtonName)
                    .foregroundColor(Color(uiColor: Constants.Colors.purple ?? .purple))
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            }
            Spacer()
        }
        .navigationTitle(Constants.Text.referralCodeViewTitle)
        .navigationBarBackButtonHidden(true)
        .padding()
        .navigationDestination(isPresented: $showSurvey) {
            SurveyView()
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: Text(Constants.Text.referralCodeViewAlertTitle),
                  message: Text(alertItem.message),
                  dismissButton: .default(Text(Constants.Text.referralCodeViewAlertButtonTitle), action: {
                showSurvey = true
            }))
        }
    }
}

#Preview {
    ReferralCodeView(mobileDeviceID: DeviceManager.shared.mobileDeviceId ?? "", token: UserDefaults.standard.string(forKey: "token") ?? "")
}
