//
//  SurveyModel.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import Foundation

struct SurveyModel {
    var dateOfBirth: Date = Date()
    var hasKids: Bool = false
}

struct SurveyResponse: Decodable {
    let changeBalance: Int
    
    enum CodingKeys: String, CodingKey {
        case changeBalance = "change_balance"
    }
}

