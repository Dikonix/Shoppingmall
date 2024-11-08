//
//  LoginView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import SwiftUI

struct LoginView: View {
    @AppStorage("_shouldShowOnOnboarding") var shouldShowOnboarding: Bool = true
    @StateObject private var viewModel = LoginViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var shouldShowHome = false
    
    var body: some View {
        VStack(spacing: 20) {
            if !viewModel.isCodeSent {
                phoneInputView
            } else if !viewModel.isCodeValid {
                codeInputView
            }
            Spacer()
        }
        .navigationTitle(Constants.Text.loginViewTitle)
        .navigationBarBackButtonHidden(true)
        .padding()
        .onChange(of: viewModel.isCodeValid) {
            if viewModel.isCodeValid {
                viewModel.showErrorMessage = false
                shouldShowHome = true
            }
        }
        
        .onChange(of: shouldShowHome) {
            if shouldShowHome {
                shouldShowOnboarding = false
                AuthManager.isAuthenticated = true
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    private var phoneInputView: some View {
        VStack(spacing: 16) {
            Text(Constants.Text.authorizationViewTitleNumber)
                .font(.title2)
            
            TextField(Constants.Text.authorizationViewNumber, text: $viewModel.user.phoneNumber)
                .keyboardType(.phonePad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                viewModel.sendPhoneNumber()
            }) {
                Text(Constants.Text.authorizationViewGetCodeButtonName)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isPhoneNumberValid ? Color(uiColor: Constants.Colors.purple ?? .purple) : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(!viewModel.isPhoneNumberValid)
            
            if viewModel.showErrorMessage == true {
                Text(Constants.Text.authorizationViewNumberErrorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 8)
            }
        }
    }
    
    private var codeInputView: some View {
        VStack(spacing: 16) {
            Text(Constants.Text.authorizationViewSMSCode)
                .font(.title2)
            
            TextField(Constants.Text.authorizationViewCode, text: $viewModel.user.smsCode)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: viewModel.user.smsCode) { oldValue, newValue in
                    if newValue.count > 6 {
                        viewModel.user.smsCode = String(newValue.prefix(6))
                    }
                }
            
            if viewModel.showErrorMessage == true {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            if !viewModel.isCodeResendAllowed {
                Text(Constants.Text.authorizationViewFirstPartOfTheRepeat + " \(viewModel.resendTimerSeconds) " + Constants.Text.authorizationViewSecondPartOfTheRepeat)
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
            
            Button(action: {
                if viewModel.isCodeSent {
                    viewModel.validateCode()
                    if viewModel.isCodeValid {
                        viewModel.checkCodeValidity()
                    } else {
                        viewModel.showErrorMessage = true
                    }
                } else {
                    if viewModel.isCodeResendAllowed {
                        viewModel.startResendTimer()
                        viewModel.sendPhoneNumber()
                    }
                }
            }) {
                Text(viewModel.isCodeResendAllowed ? Constants.Text.authorizationViewResendButtonName : Constants.Text.authorizationViewSendButtonName)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.user.smsCode.count == 6 ? Color(uiColor: Constants.Colors.purple ?? .purple) : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(!viewModel.isCodeResendAllowed && !viewModel.isCodeSent && viewModel.user.smsCode.count != 6)
        }
    }
}

#Preview {
    LoginView()
}
