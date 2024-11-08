//
//  ReviewFormView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 08.11.2024.
//

import SwiftUI

struct ReviewFormView: View {
    @ObservedObject var viewModel: AppFeedbackViewModel
    let phone =  UserDefaults.standard.string(forKey: "phone") ?? ""
    @Environment(\.presentationMode) var presentationMode
        @State private var showAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(Constants.Text.reviewFormViewAppealData)
                .font(.headline)
            
            Text(Constants.Text.reviewFormViewAccount)
                .font(.subheadline)
            TextField(Constants.Text.reviewFormViewPhoneNumber, text: .constant(phone))
                .disabled(true)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            
            Text(Constants.Text.reviewFormViewComments)
                .font(.subheadline)
            TextField(Constants.Text.reviewFormViewText, text: $viewModel.feedbackText)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            
            Text(Constants.Text.reviewFormViewInformation)
                .font(.footnote)
                .foregroundColor(.gray)
            
            Button(action: {
                showAlert = true
            }) {
                Text(Constants.Text.authorizationViewSendButtonName)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(uiColor: Constants.Colors.purple ?? .purple))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(Constants.Text.reviewFormViewThankYou),
                    message: Text(Constants.Text.reviewFormViewReviewSent),
                    dismissButton: .default(Text(Constants.Text.referralCodeViewAlertButtonTitle)) {
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            }
            
            Spacer()
            
            
        }
        .padding()
        .navigationTitle(Constants.Text.reviewFormViewTitle)
    }
}

struct TermsOfServiceView: View {
    var body: some View {
        Text(Constants.Text.appFeedbackViewTermsOfUse)
    }
}

struct UserAgreementView: View {
    var body: some View {
        Text(Constants.Text.appFeedbackViewUserAgreement)
    }
}
