//
//  LoginModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import Foundation

struct LoginModel {
    var phoneNumber: String = ""
    var smsCode: String = ""
}

struct LoginValidateCodeResponse: Decodable {
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
