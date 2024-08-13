//
//  OnboardingView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 01.08.2024.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var router: Router
    @Binding var shouldShowOnboarding: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                Image(uiImage: UIImage.shoppingmall)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 312, height: 18.24)
                    .padding()
                
                TabView {
                    PageView(title: Constants.Text.onboardingFirstSlide,
                             image: UIImage.firstPicture,
                             backgroundColor: Constants.Colors.purple ?? UIColor.blue,
                             pictureSize: 339,
                             shouldShowOnboarding: $shouldShowOnboarding)
                    .tag(0)
                    PageView(title: Constants.Text.onboardingSecondSlide,
                             image: UIImage.secondPicture,
                             backgroundColor: Constants.Colors.coral ?? UIColor.purple,
                             pictureSize: 350,
                             shouldShowOnboarding: $shouldShowOnboarding)
                    .tag(1)
                    PageViewWithButtons(title: Constants.Text.onboardingThirdSlideTitle,
                                        subtitle: Constants.Text.onboardingThirdSlideSubtitle,
                                        image: UIImage.thirdPicture,
                                        textFirstButton: Constants.Text.onboardingThirdSlideTextFirstButton,
                                        textSecondButton: Constants.Text.onboardingThirdSlideTextSecondButton,
                                        backgroundColor: Constants.Colors.purple ?? UIColor.blue,
                                        pictureSize: 284,
                                        shouldShowOnboarding: $shouldShowOnboarding)
                    .tag(2)
                    PageViewWithButtons(title: Constants.Text.onboardingFourthSlideTitle,
                                        subtitle: Constants.Text.onboardingFourthSlideSubtitle,
                                        image: UIImage.fourthPicture,
                                        textFirstButton: Constants.Text.onboardingFourthSlideTextFirstButton,
                                        textSecondButton: Constants.Text.onboardingFourthSlideTextSecondButton,
                                        backgroundColor: Constants.Colors.black ?? UIColor.black,
                                        pictureSize: 304,
                                        shouldShowOnboarding: $shouldShowOnboarding)
                    .tag(3)
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
                .frame(width: 312, height: 594)
                .padding()
                
                Button(action: {
                    shouldShowOnboarding.toggle()
                }, label: {
                    Text(Constants.Text.onboardingButton)
                        .foregroundStyle(Color(uiColor: .lightGray))
                })
                .frame(width: 312, height: 15, alignment: .trailing)
            }
        }
    }
}

struct PageView: View {
    let title: String
    let image: UIImage
    let backgroundColor: UIColor
    let pictureSize: CGFloat
    @Binding var shouldShowOnboarding: Bool
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: pictureSize, height: pictureSize)
            Text(title)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .foregroundStyle( .white)
                .padding()
                .frame(maxWidth: 230)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(width: 312, height: 594)
        .background(Color(uiColor: backgroundColor))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct PageViewWithButtons: View {
    let title: String
    let subtitle: String
    let image: UIImage
    let textFirstButton: String
    let textSecondButton: String
    let backgroundColor: UIColor
    let pictureSize: CGFloat
    @Binding var shouldShowOnboarding: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: pictureSize, height: pictureSize)
            Spacer().frame(height: 20)
            Text(title)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .frame(maxWidth: 230)
                .fixedSize(horizontal: false, vertical: true)
                .padding(3)
            Text(subtitle)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .frame(maxWidth: 300)
                .fixedSize(horizontal: false, vertical: true)
                .padding(3)
            Spacer()
            Button(action: {
                
            }, label: {
                Text(textFirstButton)
            })
            .frame(width: 264, height: 34)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.bottom, 10)
            Button(action: {
                
            }, label: {
                Text(textSecondButton)
                    .foregroundStyle(.white)
            })
            .padding(.bottom, 40)
        }
        .frame(width: 312, height: 594)
        .background(Color(uiColor: backgroundColor))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    OnboardingView(shouldShowOnboarding: .constant(true))
}
