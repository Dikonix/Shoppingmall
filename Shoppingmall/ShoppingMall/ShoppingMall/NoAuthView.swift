//
//  NoAuthView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import SwiftUI

struct NoAuthView: View {
    @State private var showAuthorization = false
    @State private var showLogin = false
    let pictureSize: CGFloat = 304
    
    var body: some View {
        VStack {
            Spacer()
            Image(uiImage: UIImage.fourthPicture)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: pictureSize, height: pictureSize)
            Spacer().frame(height: 20)
            Text(Constants.Text.onboardingFourthSlideTitle)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .frame(maxWidth: 230)
                .fixedSize(horizontal: false, vertical: true)
                .padding(3)
            Text(Constants.Text.noAuthSubtitle)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.black)
                .frame(maxWidth: 300)
                .fixedSize(horizontal: false, vertical: true)
                .padding(3)
            Spacer()
            Button(action: {
                showAuthorization = true
            }, label: {
                Text(Constants.Text.onboardingFourthSlideTextFirstButton)
                    .foregroundStyle(.white)
            })
            .frame(width: 264, height: 34)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Button(action: {
                showLogin = true
            }, label: {
                Text(Constants.Text.onboardingFourthSlideTextSecondButton)
                    .foregroundStyle(.black)
            })
            .padding(.bottom, 50)
        }
        .frame(width: 312, height: 594)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .navigationDestination(isPresented: $showAuthorization) {
            AuthorizationView()
        }
        .navigationDestination(isPresented: $showLogin) {
            LoginView()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NoAuthView()
}
