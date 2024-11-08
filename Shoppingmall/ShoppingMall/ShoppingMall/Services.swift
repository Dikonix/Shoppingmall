//
//  Services.swift
//  ShoppingMall
//
//  Created by Diana Brik on 02.11.2024.
//

import SwiftUI

class Services {
    static let shared = Services()
    
    func formatDate(from timestampString: String) -> String {
        if let timestamp = TimeInterval(timestampString) {
            let date = Date(timeIntervalSince1970: timestamp)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            return dateFormatter.string(from: date)
        }
        return "Неверный формат даты"
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
