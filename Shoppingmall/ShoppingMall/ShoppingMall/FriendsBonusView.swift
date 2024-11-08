//
//  PointsForFriendsView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 11.10.2024.
//

import SwiftUI

protocol FriendsBonusViewModel: ObservableObject {
    var promocode: String { get }
}

struct FriendsBonusView<ViewModel: FriendsBonusViewModel>: View {
    @ObservedObject private var viewModel: ViewModel
    @State private var showCopiedMessage = false
    @State private var isShareSheetPresented = false
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(Constants.Text.friendsBonusViewOfferTitle)
                    .font(.title)
                
                Divider()
                    .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text(Constants.Text.friendsBonusViewFirstOffer)
                    Text(Constants.Text.friendsBonusViewSecondOffer)
                }
                .padding()
                
                HStack {
                    Text(viewModel.promocode)
                        .foregroundColor(.black)
                        .padding(.leading, 8)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Button(action: {
                        UIPasteboard.general.string = viewModel.promocode
                        withAnimation {
                            showCopiedMessage = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                showCopiedMessage = false
                            }
                        }
                    }) {
                        Image(systemName: "doc.on.doc")
                            .foregroundColor(.blue)
                            .padding(.horizontal, 8)
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .frame(maxWidth: .infinity)
                .overlay(
                    Group {
                        if showCopiedMessage {
                            Text(Constants.Text.friendsBonusViewCopy)
                                .font(.caption)
                                .padding(8)
                                .background(Color.black.opacity(0.7))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .offset(y: -50)
                                .transition(.opacity.combined(with: .scale))
                        }
                    }
                )
                
                Button {
                    isShareSheetPresented = true
                } label: {
                    Text(Constants.Text.friendsBonusViewSharePromocode)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .sheet(isPresented: $isShareSheetPresented) {
                    ShareSheet(activityItems: [viewModel.promocode])
                }
                
            }
            .padding()
        }
        .navigationTitle(Constants.Text.bonusViewFriendsBonus)
    }
}

#Preview {
    FriendsBonusView(viewModel: MockFriendsBonusViewModel())
}

class MockFriendsBonusViewModel: FriendsBonusViewModel {
    @Published var promocode: String = "MY-AWESOME-PROMOCODE"
}
