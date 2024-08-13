//
//  Constants.swift
//  ShoppingMall
//
//  Created by Diana Brik on 01.08.2024.
//

import UIKit

enum Constants {
    enum Colors {
        static let purple: UIColor? = UIColor(named: "AccentColor")
        static let coral: UIColor? = UIColor(named: "AccentColor2")
        static let black: UIColor? = UIColor(named: "AccentColor3")
    }
    
    enum Text {
        static let onboardingFirstSlide = Bundle.main.localizedString(forKey: "Onboarding.FirstSlide",
                                                                      value: "",
                                                                      table: "Localizable")
        static let onboardingSecondSlide = Bundle.main.localizedString(forKey: "Onboarding.SecondSlide",
                                                                       value: "",
                                                                       table: "Localizable")
        static let onboardingThirdSlideTitle = Bundle.main.localizedString(forKey: "Onboarding.ThirdSlide.Title",
                                                                      value: "",
                                                                      table: "Localizable")
        static let onboardingThirdSlideSubtitle = Bundle.main.localizedString(forKey: "Onboarding.ThirdSlide.Subtitle",
                                                                      value: "",
                                                                      table: "Localizable")
        static let onboardingThirdSlideTextFirstButton = Bundle.main.localizedString(forKey: "Onboarding.ThirdSlide.TextFirstButton",
                                                                      value: "",
                                                                      table: "Localizable")
        static let onboardingThirdSlideTextSecondButton = Bundle.main.localizedString(forKey: "Onboarding.ThirdSlide.TextSecondButton",
                                                                      value: "",
                                                                      table: "Localizable")
        static let onboardingFourthSlideTitle = Bundle.main.localizedString(forKey: "Onboarding.FourthSlide.Title",
                                                                      value: "",
                                                                      table: "Localizable")
        static let onboardingFourthSlideSubtitle = Bundle.main.localizedString(forKey: "Onboarding.FourthSlide.Subtitle",
                                                                      value: "",
                                                                      table: "Localizable")
        static let onboardingFourthSlideTextFirstButton = Bundle.main.localizedString(forKey: "Onboarding.FourthSlide.TextFirstButton",
                                                                      value: "",
                                                                      table: "Localizable")
        static let onboardingFourthSlideTextSecondButton = Bundle.main.localizedString(forKey: "Onboarding.FourthSlide.TextSecondButton",
                                                                      value: "",
                                                                      table: "Localizable")
        static let onboardingButton = Bundle.main.localizedString(forKey: "Onboarding.Button",
                                                                      value: "",
                                                                      table: "Localizable")
    }
}
