//
//  AuthorizationModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 06.11.2024.
//

import Foundation

struct UserModel {
    var phoneNumber: String = ""
    var smsCode: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
}

struct ValidateCodeResponse: Decodable {
    var id: String
    var mobileId: String?
    var phone: String
    var referralCode: String
    var rememberToken: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case mobileId = "mobile_id"
        case phone
        case referralCode = "referral_code"
        case rememberToken = "remember_token"
    }
}

struct SaveProfileDataResponse: Decodable {
    var id: String
    var mobileId: String?
    var phone: String
    var name: String
    var email: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case mobileId = "mobile_id"
        case phone
        case name
        case email
    }
}
