//
//  BonusPointsView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import SwiftUI

struct BonusPointsView: View {
    @State private var showReferral = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: UIImage.bonus)
                .resizable()
            
            Image(systemName: "xmark.square.fill")
                .resizable()
                .foregroundColor(Color.white)
                .scaledToFit()
                .frame(width: 32, height: 32)
                .padding()
                .padding(.trailing, 30)
                .padding(.top, 30)
                .onTapGesture {
                    showReferral = true
                }
        }
        .navigationDestination(isPresented: $showReferral) {
           ReferralCodeView()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    BonusPointsView()
}
