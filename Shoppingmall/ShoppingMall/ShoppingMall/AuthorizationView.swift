//
//  AuthorizationView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 06.11.2024.
//

import SwiftUI

struct AuthorizationView: View {
    @StateObject private var viewModel = AuthorizationViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if !viewModel.isCodeSent {
                phoneInputView
            } else if !viewModel.isCodeValid {
                codeInputView
            } else {
                profileInputView
            }
            Spacer()
        }
        .navigationTitle(Constants.Text.authorizationViewTitle)
        .navigationBarBackButtonHidden(true)
        .padding()
        .navigationDestination(isPresented: $viewModel.isDataSavedSuccessfully) {
            BonusPointsView()
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
                Text(Constants.Text.authorizationViewFirstPartOfTheRepeat +  " \(viewModel.resendTimerSeconds) " + Constants.Text.authorizationViewSecondPartOfTheRepeat)
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
            
            Button(action: {
                if viewModel.isCodeSent {
                    viewModel.validateCode()
                    if viewModel.isCodeValid {
                        viewModel.showErrorMessage = false
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
    
    private var profileInputView: some View {
        VStack(spacing: 16) {
            Text(Constants.Text.authorizationViewEnterDataProfile)
                .font(.title2)
            
            TextField(Constants.Text.authorizationViewName, text: $viewModel.user.firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField(Constants.Text.authorizationViewSurname, text: $viewModel.user.lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField(Constants.Text.authorizationViewEmail, text: $viewModel.user.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            Button(action: {
                viewModel.saveProfileData()
                viewModel.isDataSavedSuccessfully = true
            }) {
                Text(Constants.Text.authorizationViewSaveButtonName)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isProfileDataValid ? Color(uiColor: Constants.Colors.purple ?? .purple) : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(!viewModel.isProfileDataValid)
            
            //TODO: Закомментировала данные, потому что при запросе от сервера не могу получить данные, приходит статус 405, либо возращает ошибку: token must be string, null used - а я и так передаю пустую строку или пыталась передавать remember_token, который дается при регистрации, но сервер все равно эту же ошибку выкидывает. Возникает вопрос, что за token он просит, если remember_token не подходит
//            if viewModel.showErrorMessage {
//                Text(viewModel.errorMessage)
//                    .foregroundColor(.red)
//                    .padding(.top, 8)
//            }
        }
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView()
    }
}
