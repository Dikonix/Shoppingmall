//
//  AppFeedbackView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 08.11.2024.
//

import SwiftUI

struct AppFeedbackView: View {
    @StateObject private var viewModel = AppFeedbackViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text(Constants.Text.appFeedbackViewRate)
                .font(.headline)
            
            HStack {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= viewModel.rating ? "star.fill" : "star")
                        .foregroundColor(Color(uiColor: Constants.Colors.purple ?? .purple))
                        .onTapGesture {
                            viewModel.rating = index
                        }
                }
            }
            
            Button(action: viewModel.handleRatingSubmit) {
                Text(Constants.Text.appFeedbackViewButtonRateName)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.rating > 0 ? Color(uiColor: Constants.Colors.purple ?? .purple) : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(viewModel.rating == 0)
            
            Spacer()
            
            Text(Constants.Text.appFeedbackViewDocumentation)
                .font(.headline)
            
            List {
                NavigationLink(Constants.Text.appFeedbackViewTermsOfUse, destination: TermsOfServiceView())
                NavigationLink(Constants.Text.appFeedbackViewUserAgreement, destination: UserAgreementView())
            }
            .listStyle(PlainListStyle())
        }
        .padding()
        .navigationTitle(Constants.Text.menuViewAboutAppTitle)
        .navigationDestination(isPresented: $viewModel.showReviewForm) {
            ReviewFormView(viewModel: viewModel)
        }
        .alert(isPresented: $viewModel.showRatingModal) {
            Alert(title: Text(Constants.Text.appFeedbackViewThanks), message: Text(Constants.Text.appFeedbackViewAllertMessage), dismissButton: .default(Text(Constants.Text.referralCodeViewAlertButtonTitle), action: {
                viewModel.isFeedbackSubmitted = true
            }))
        }
        .onChange(of: viewModel.isFeedbackSubmitted) { submitted, no in
            if submitted {
                viewModel.rating = 0
            }
        }
    }
}
