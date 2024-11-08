//
//  FrendsBonusViewModelImpl.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import Foundation

class FrendsBonusViewModelImpl: FriendsBonusViewModel {
    @Published private(set) var promocode: String = (UserDefaults.standard.string(forKey: "referralCode") ?? "")
}
