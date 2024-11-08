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
        static let home = Bundle.main.localizedString(forKey: "Home",
                                                      value: "",
                                                      table: "Localizable")
        static let catalog = Bundle.main.localizedString(forKey: "Catalog",
                                                      value: "",
                                                      table: "Localizable")
        static let bonus = Bundle.main.localizedString(forKey: "Bonus",
                                                      value: "",
                                                      table: "Localizable")
        static let menu = Bundle.main.localizedString(forKey: "Menu",
                                                      value: "",
                                                      table: "Localizable")
        static let homeViewGoodAfternoon = Bundle.main.localizedString(forKey: "HomeView.GoodAfternoon",
                                                      value: "",
                                                      table: "Localizable")
        
        static let homeViewNews = Bundle.main.localizedString(forKey: "HomeView.News",
                                                      value: "",
                                                      table: "Localizable")
        static let homeViewNewOffers = Bundle.main.localizedString(forKey: "HomeView.NewOffers",
                                                      value: "",
                                                      table: "Localizable")
        static let homeViewUsefulInformation = Bundle.main.localizedString(forKey: "HomeView.UsefulInformation",
                                                      value: "",
                                                      table: "Localizable")
        static let homeViewEvents = Bundle.main.localizedString(forKey: "HomeView.Events",
                                                      value: "",
                                                      table: "Localizable")
        static let homeViewTextAllButton = Bundle.main.localizedString(forKey: "HomeView.TextAllButton",
                                                      value: "",
                                                      table: "Localizable")
        static let noAuthSubtitle = Bundle.main.localizedString(forKey: "NoAuth.Subtitle",
                                                                value: "",
                                                                table: "Localizable")
        static let authorizationViewTitle = Bundle.main.localizedString(forKey: "AuthorizationView.Title",
                                                                value: "",
                                                                table: "Localizable")
        static let authorizationViewTitleNumber = Bundle.main.localizedString(forKey: "AuthorizationView.TitleNumber",
                                                                value: "",
                                                                table: "Localizable")
        static let authorizationViewNumber = Bundle.main.localizedString(forKey: "AuthorizationView.Number",
                                                                value: "",
                                                                table: "Localizable")
        static let authorizationViewGetCodeButtonName = Bundle.main.localizedString(forKey: "AuthorizationView.GetCodeButtonName",
                                                                value: "",
                                                                table: "Localizable")
        static let authorizationViewNumberErrorMessage = Bundle.main.localizedString(forKey: "AuthorizationView.NumberErrorMessage",
                                                                value: "",
                                                                table: "Localizable")
        static let authorizationViewSMSCode = Bundle.main.localizedString(forKey: "AuthorizationView.SMSCode",
                                                                value: "",
                                                                table: "Localizable")
        static let authorizationViewCode = Bundle.main.localizedString(forKey: "AuthorizationView.Code",
                                                                value: "",
                                                                table: "Localizable")
        static let authorizationViewFirstPartOfTheRepeat = Bundle.main.localizedString(forKey: "AuthorizationView.FirstPartOfTheRepeat",
                                                                value: "",
                                                                table: "Localizable")
        static let authorizationViewSecondPartOfTheRepeat = Bundle.main.localizedString(forKey: "AuthorizationView.SecondPartOfTheRepeat",
                                                                value: "",
                                                                table: "Localizable")
        static let authorizationViewResendButtonName = Bundle.main.localizedString(forKey: "AuthorizationView.ResendButtonName",
                                                                value: "",
                                                                table: "Localizable")
        static let authorizationViewSendButtonName = Bundle.main.localizedString(forKey: "AuthorizationView.SendButtonName",
                                                                value: "",
                                                                table: "Localizable")
        static let authorizationViewEnterDataProfile = Bundle.main.localizedString(forKey: "AuthorizationView.EnterDataProfile",
                                                                value: "",
                                                                table: "Localizable")
        static let authorizationViewName = Bundle.main.localizedString(forKey: "AuthorizationView.Name",
                                                                value: "",
                                                                table: "Localizable")
        static let authorizationViewSurname = Bundle.main.localizedString(forKey: "AuthorizationView.Surname",
                                                                value: "",
                                                                table: "Localizable")
        static let authorizationViewEmail = Bundle.main.localizedString(forKey: "AuthorizationView.Email",
                                                                value: "",
                                                                table: "Localizable")
        static let authorizationViewSaveButtonName = Bundle.main.localizedString(forKey: "AuthorizationView.SaveButtonName",
                                                                value: "",
                                                                table: "Localizable")
        static let bonusPointsModelViewErrorMessage = Bundle.main.localizedString(forKey: "BonusPointsModelView.ErrorMessage",
                                                                value: "",
                                                                table: "Localizable")
        static let referralCodeViewModelInvalidAlertMessage = Bundle.main.localizedString(forKey: "ReferralCodeViewModel.InvalidAlertMessage",
                                                                value: "",
                                                                table: "Localizable")
        static let referralCodeViewModelEmptyAlertMessage = Bundle.main.localizedString(forKey: "ReferralCodeViewModel.EmptyAlertMessage",
                                                                value: "",
                                                                table: "Localizable")
        static let referralCodeViewModelReadyAlertMessage = Bundle.main.localizedString(forKey: "ReferralCodeViewModel.ReadyAlertMessage",
                                                                value: "",
                                                                table: "Localizable")
        static let referralCodeViewEnterPromocode = Bundle.main.localizedString(forKey: "ReferralCodeView.EnterPromocode",
                                                                value: "",
                                                                table: "Localizable")
        static let referralCodeViewPromocode = Bundle.main.localizedString(forKey: "ReferralCodeView.Promocode",
                                                                value: "",
                                                                table: "Localizable")
        static let referralCodeViewGetPointsButtonName = Bundle.main.localizedString(forKey: "ReferralCodeView.GetPointsButtonName",
                                                                value: "",
                                                                table: "Localizable")
        static let referralCodeViewNoPromocodeButtonName = Bundle.main.localizedString(forKey: "ReferralCodeView.NoPromocodeButtonName",
                                                                value: "",
                                                                table: "Localizable")
        static let referralCodeViewTitle = Bundle.main.localizedString(forKey: "ReferralCodeView.Title",
                                                                value: "",
                                                                table: "Localizable")
        static let referralCodeViewAlertTitle = Bundle.main.localizedString(forKey: "ReferralCodeView.AlertTitle",
                                                                value: "",
                                                                table: "Localizable")
        static let referralCodeViewAlertButtonTitle = Bundle.main.localizedString(forKey: "ReferralCodeView.AlertButtonTitle",
                                                                value: "",
                                                                table: "Localizable")
        static let surveyViewModelAlertWarning = Bundle.main.localizedString(forKey: "SurveyViewModel.AlertWarning",
                                                                value: "",
                                                                table: "Localizable")
        static let surveyViewModelAlertError = Bundle.main.localizedString(forKey: "SurveyViewModel.AlertError",
                                                                value: "",
                                                                table: "Localizable")
        static let surveyViewFirstQuestion = Bundle.main.localizedString(forKey: "SurveyView.FirstQuestion",
                                                                value: "",
                                                                table: "Localizable")
        static let surveyViewSecondQuestion = Bundle.main.localizedString(forKey: "SurveyView.SecondQuestion",
                                                                value: "",
                                                                table: "Localizable")
        static let surveyViewYes = Bundle.main.localizedString(forKey: "SurveyView.Yes",
                                                                value: "",
                                                                table: "Localizable")
        static let surveyViewNo = Bundle.main.localizedString(forKey: "SurveyView.No",
                                                                value: "",
                                                                table: "Localizable")
        static let surveyViewAnswerButtonName = Bundle.main.localizedString(forKey: "SurveyView.AnswerButtonName",
                                                                value: "",
                                                                table: "Localizable")
        static let surveyViewFirstPartOfPoints = Bundle.main.localizedString(forKey: "SurveyView.FirstPartOfPoints",
                                                                value: "",
                                                                table: "Localizable")
        static let surveyViewSecondPartOfPoints = Bundle.main.localizedString(forKey: "SurveyView.SecondPartOfPoints",
                                                                value: "",
                                                                table: "Localizable")
        static let surveyViewTitle = Bundle.main.localizedString(forKey: "SurveyView.Title",
                                                                value: "",
                                                                table: "Localizable")
        static let loginViewModelErrorMessage = Bundle.main.localizedString(forKey: "LoginViewModel.ErrorMessage",
                                                                value: "",
                                                                table: "Localizable")
        static let loginViewModelFailedMessage = Bundle.main.localizedString(forKey: "LoginViewModel.FailedMessage",
                                                                value: "",
                                                                table: "Localizable")
        static let loginViewModelDecodingErrorMessage = Bundle.main.localizedString(forKey: "LoginViewModel.DecodingErrorMessage",
                                                                value: "",
                                                                table: "Localizable")
        static let loginViewTitle = Bundle.main.localizedString(forKey: "LoginView.Title",
                                                                value: "",
                                                                table: "Localizable")
        static let homeViewNoData = Bundle.main.localizedString(forKey: "HomeView.NoData",
                                                                value: "",
                                                                table: "Localizable")
        static let newsViewNoDataRepeatLater = Bundle.main.localizedString(forKey: "NewsView.NoDataRepeatLater",
                                                                value: "",
                                                                table: "Localizable")
        static let catalogViewModelShops = Bundle.main.localizedString(forKey: "CatalogViewModel.Shops",
                                                                value: "",
                                                                table: "Localizable")
        static let catalogViewModelFood = Bundle.main.localizedString(forKey: "CatalogViewModel.Food",
                                                                value: "",
                                                                table: "Localizable")
        static let catalogViewModelEntertainment = Bundle.main.localizedString(forKey: "CatalogViewModel.Entertainment",
                                                                value: "",
                                                                table: "Localizable")
        static let catalogViewModelServices = Bundle.main.localizedString(forKey: "CatalogViewModel.Services",
                                                                value: "",
                                                                table: "Localizable")
        static let catalogViewModelFitness = Bundle.main.localizedString(forKey: "CatalogViewModel.Fitness",
                                                                value: "",
                                                                table: "Localizable")
        static let catalogViewModelMovie = Bundle.main.localizedString(forKey: "CatalogViewModel.Movie",
                                                                value: "",
                                                                table: "Localizable")
        static let catalogDetailViewSearch = Bundle.main.localizedString(forKey: "CatalogDetailView.Search",
                                                                value: "",
                                                                table: "Localizable")
        static let catalogDetailViewNoData = Bundle.main.localizedString(forKey: "CatalogDetailView.NoData",
                                                                value: "",
                                                                table: "Localizable")
        static let promotionViewModelImplTitle = Bundle.main.localizedString(forKey: "PromotionViewModelImpl.Title",
                                                                value: "",
                                                                table: "Localizable")
        static let objectDetailsViewFloor = Bundle.main.localizedString(forKey: "ObjectDetailsView.Floor",
                                                                value: "",
                                                                table: "Localizable")
        static let bonusViewGiftCatalog = Bundle.main.localizedString(forKey: "BonusView.GiftCatalog",
                                                                value: "",
                                                                table: "Localizable")
        static let bonusViewFriendsBonus = Bundle.main.localizedString(forKey: "BonusView.FriendsBonus",
                                                                value: "",
                                                                table: "Localizable")
        static let bonusViewMyGifts = Bundle.main.localizedString(forKey: "BonusView.MyGifts",
                                                                value: "",
                                                                table: "Localizable")
        static let bonusViewHistoryTransactions = Bundle.main.localizedString(forKey: "BonusView.HistoryTransactions",
                                                                value: "",
                                                                table: "Localizable")
        static let bonusViewBonus = Bundle.main.localizedString(forKey: "BonusView.Bonus",
                                                                value: "",
                                                                table: "Localizable")
        static let friendsBonusViewOfferTitle = Bundle.main.localizedString(forKey: "FriendsBonusView.OfferTitle",
                                                                value: "",
                                                                table: "Localizable")
        static let friendsBonusViewFirstOffer = Bundle.main.localizedString(forKey: "FriendsBonusView.FirstOffer",
                                                                value: "",
                                                                table: "Localizable")
        static let friendsBonusViewSecondOffer = Bundle.main.localizedString(forKey: "FriendsBonusView.SecondOffer",
                                                                value: "",
                                                                table: "Localizable")
        static let friendsBonusViewCopy = Bundle.main.localizedString(forKey: "FriendsBonusView.Copy",
                                                                value: "",
                                                                table: "Localizable")
        static let friendsBonusViewSharePromocode = Bundle.main.localizedString(forKey: "FriendsBonusView.SharePromocode",
                                                                value: "",
                                                                table: "Localizable")
        static let menuViewNewsAndEventsTitle = Bundle.main.localizedString(forKey: "MenuView.NewsAndEventsTitle",
                                                                value: "",
                                                                table: "Localizable")
        static let menuViewMapsTitle = Bundle.main.localizedString(forKey: "MenuView.MapsTitle",
                                                                value: "",
                                                                table: "Localizable")
        static let menuViewSettingsTitle = Bundle.main.localizedString(forKey: "MenuView.SettingsTitle",
                                                                value: "",
                                                                table: "Localizable")
        static let menuViewAboutAppTitle = Bundle.main.localizedString(forKey: "MenuView.AboutAppTitle",
                                                                value: "",
                                                                table: "Localizable")
        static let menuViewAbout = Bundle.main.localizedString(forKey: "MenuView.About",
                                                                value: "",
                                                                table: "Localizable")
        static let settingsVeiwNotifications = Bundle.main.localizedString(forKey: "SettingsVeiw.Notifications",
                                                                value: "",
                                                                table: "Localizable")
        static let settingsVeiwPromotionsInStores = Bundle.main.localizedString(forKey: "SettingsVeiw.PromotionsInStores",
                                                                value: "",
                                                                table: "Localizable")
        static let settingsVeiwChildrenEvents = Bundle.main.localizedString(forKey: "SettingsVeiw.ChildrenEvents",
                                                                value: "",
                                                                table: "Localizable")
        static let settingsVeiwEventsInTheMall = Bundle.main.localizedString(forKey: "SettingsVeiw.EventsInTheMall",
                                                                value: "",
                                                                table: "Localizable")
        static let settingsVeiwProfileData = Bundle.main.localizedString(forKey: "SettingsVeiw.ProfileData",
                                                                value: "",
                                                                table: "Localizable")
        static let settingsVeiwLogoutOfProfile = Bundle.main.localizedString(forKey: "SettingsVeiw.LogoutOfProfile",
                                                                value: "",
                                                                table: "Localizable")
        static let settingsVeiwAuthorization = Bundle.main.localizedString(forKey: "SettingsVeiw.Authorization",
                                                                value: "",
                                                                table: "Localizable")
        static let profileViewModelImplErrorMessage = Bundle.main.localizedString(forKey: "ProfileViewModelImpl.ErrorMessage",
                                                                value: "",
                                                                table: "Localizable")
        static let profileViewTitle = Bundle.main.localizedString(forKey: "ProfileView.Title",
                                                                value: "",
                                                                table: "Localizable")
        static let profileViewPhone = Bundle.main.localizedString(forKey: "ProfileView.Phone",
                                                                value: "",
                                                                table: "Localizable")
        static let mapViewButtonTitle = Bundle.main.localizedString(forKey: "MapView.ButtonTitle",
                                                                value: "",
                                                                table: "Localizable")
        static let mapViewAddress = Bundle.main.localizedString(forKey: "MapView.Address",
                                                                value: "",
                                                                table: "Localizable")
        static let appFeedbackViewRate = Bundle.main.localizedString(forKey: "AppFeedbackView.Rate",
                                                                value: "",
                                                                table: "Localizable")
        static let appFeedbackViewButtonRateName = Bundle.main.localizedString(forKey: "AppFeedbackView.ButtonRateName",
                                                                value: "",
                                                                table: "Localizable")
        static let appFeedbackViewDocumentation = Bundle.main.localizedString(forKey: "AppFeedbackView.Documentation",
                                                                value: "",
                                                                table: "Localizable")
        static let appFeedbackViewTermsOfUse = Bundle.main.localizedString(forKey: "AppFeedbackView.TermsOfUse",
                                                                value: "",
                                                                table: "Localizable")
        static let appFeedbackViewUserAgreement = Bundle.main.localizedString(forKey: "AppFeedbackView.UserAgreement",
                                                                value: "",
                                                                table: "Localizable")
        static let appFeedbackViewThanks = Bundle.main.localizedString(forKey: "AppFeedbackView.Thanks",
                                                                value: "",
                                                                table: "Localizable")
        static let appFeedbackViewAllertMessage = Bundle.main.localizedString(forKey: "AppFeedbackView.AllertMessage",
                                                                value: "",
                                                                table: "Localizable")
        static let reviewFormViewTitle = Bundle.main.localizedString(forKey: "ReviewFormView.Title",
                                                                value: "",
                                                                table: "Localizable")
        static let reviewFormViewAppealData = Bundle.main.localizedString(forKey: "ReviewFormView.AppealData",
                                                                value: "",
                                                                table: "Localizable")
        static let reviewFormViewAccount = Bundle.main.localizedString(forKey: "ReviewFormView.Account",
                                                                value: "",
                                                                table: "Localizable")
        static let reviewFormViewPhoneNumber = Bundle.main.localizedString(forKey: "ReviewFormView.PhoneNumber",
                                                                value: "",
                                                                table: "Localizable")
        static let reviewFormViewComments = Bundle.main.localizedString(forKey: "ReviewFormView.Comments",
                                                                value: "",
                                                                table: "Localizable")
        static let reviewFormViewText = Bundle.main.localizedString(forKey: "ReviewFormView.Text",
                                                                value: "",
                                                                table: "Localizable")
        static let reviewFormViewInformation = Bundle.main.localizedString(forKey: "ReviewFormView.Information",
                                                                value: "",
                                                                table: "Localizable")
        static let reviewFormViewThankYou = Bundle.main.localizedString(forKey: "ReviewFormView.ThankYou",
                                                                value: "",
                                                                table: "Localizable")
        static let reviewFormViewReviewSent = Bundle.main.localizedString(forKey: "ReviewFormView.ReviewSent",
                                                                value: "",
                                                                table: "Localizable")
    }
}
