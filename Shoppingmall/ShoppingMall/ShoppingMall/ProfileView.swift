//
//  ProfileView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import SwiftUI

struct ProfileDataDTO {
    let phone: String
    let name: String
    let surname: String
    let email: String
}

protocol ProfileViewModel: ObservableObject {
    var data: ProfileDataDTO? { get }
    func saveProfileData()
}

struct ProfileView<ViewModel: ProfileViewModel & ObservableObject>: View {
    @ObservedObject private var viewModel: ViewModel
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                TextField(Constants.Text.authorizationViewName, text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField(Constants.Text.authorizationViewSurname, text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField(Constants.Text.authorizationViewEmail, text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField(Constants.Text.profileViewPhone, text: $phone)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.phonePad)
            }
            
            Button(action: {
                viewModel.saveProfileData()
            }) {
                Text(Constants.Text.authorizationViewSaveButtonName)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(uiColor: Constants.Colors.purple ?? .purple))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top)
            
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Constants.Text.profileViewTitle)
        .onAppear {
            if let userProfile = viewModel.data {
                firstName = userProfile.name
                lastName = userProfile.surname
                email = userProfile.email
                phone = userProfile.phone
            }
        }
    }
}

