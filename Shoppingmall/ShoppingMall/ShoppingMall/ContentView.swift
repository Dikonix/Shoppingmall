//
//  ContentView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 31.07.2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("_shouldShowOnOnboarding") var shouldShowOnboarding: Bool = true
    
    var body: some View {
        TabBarRouter(shouldShowOnboarding: $shouldShowOnboarding)
        .fullScreenCover(isPresented: $shouldShowOnboarding, content: {
            OnboardingView(shouldShowOnboarding: $shouldShowOnboarding)
        })
    }
}

#Preview {
    ContentView()
}
