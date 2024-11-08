//
//  AuthManager.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import Foundation

class AuthManager {
    private let authKey = "isAuthenticated"

    static var isAuthenticated: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isAuthenticated")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isAuthenticated")
        }
    }

    static func logOut() {
        UserDefaults.standard.set(false, forKey: "isAuthenticated")
    }
}

