//
//  ReferralCodeModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let gender: String
    let registrationByPromoCode: Bool
    let referralCode: String
    let pointsBalance: Int
    let totalPointsAccumulated: Int
    let totalPointsSpent: Int
    let countInvitedUsers: Int
}

struct UpdateUserRequest: Codable {
    let token: String
    let name: String
    let email: String
    let gender: String
    let registrationByPromoCode: Bool
    let referralCode: String
    let enablePushPromotion: Bool
    let enablePushEvent: Bool
    let enablePushChildren: Bool
    let finishPoll: Bool
    let dateBirth: Int
    let haveKids: Bool
    let countInvitedUsers: Int
    let totalPointsAccumulated: Int
    let totalPointsSpent: Int
    let countOffersPurchased: Int
    let maximumPurchasedOffers: Int
    let appEvaluation: Int
}

struct AlertItem: Identifiable {
    let id = UUID()
    let message: String
}
