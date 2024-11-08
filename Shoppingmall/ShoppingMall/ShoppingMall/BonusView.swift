//
//  BonusView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 13.08.2024.
//

import SwiftUI

protocol BonusViewModel: ObservableObject {
    var balance: Int { get }
}

struct BonusView<ViewModel: BonusViewModel>: View {
    @ObservedObject private var viewModel: ViewModel
    @State private var isAuthenticated: Bool = AuthManager.isAuthenticated
    @State private var showNoAuth = false
    private let mobileDeviceId = DeviceManager.shared.mobileDeviceId
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            if isAuthenticated {
            BonusMenuHeader() {
                BalanceIndicator(balance: viewModel.balance)
            }
            
            VStack {
               
                    NavigationLink {
                        GiftsCatalogView(viewModel: GiftsCatalogViewModelImpl())
                    } label: {
                        BonusMenuItem(
                            title: Constants.Text.bonusViewGiftCatalog,
                            image: Image(systemName: "cart")
                        )
                    }
                    
                    NavigationLink {
                        FriendsBonusView(viewModel: FrendsBonusViewModelImpl())
                    } label: {
                        BonusMenuItem(
                            title: Constants.Text.bonusViewFriendsBonus,
                            image: Image(systemName: "person.badge.plus")
                        )
                    }
                    
                    NavigationLink {
                        MyGiftsCatalogView(viewModel: MyGiftsViewModel(mobileDeviceId: mobileDeviceId ?? ""))
                    } label: {
                        BonusMenuItem(
                            title: Constants.Text.bonusViewMyGifts,
                            image: Image(systemName: "gift")
                        )
                    }
                    
                    NavigationLink {
                        TransactionsHistoryView(viewModel: TransactionsHistoryViewModel())
                    } label: {
                        BonusMenuItem(
                            title: Constants.Text.bonusViewHistoryTransactions,
                            image: Image(systemName: "list.number")
                        )
                    }
                }
                
            } else {
                NoAuthView()
            }
        }
        .onAppear {
            isAuthenticated = AuthManager.isAuthenticated
        }
    }
}

private struct BonusMenuHeader<Content: View>: View {
    let content: () -> Content
    
    var body: some View {
        HStack(alignment: .center) {
            Text(Constants.Text.bonusViewBonus)
                .font(.title)
            Spacer()
            content()
        }
        .padding(.vertical, 24)
        .padding(.horizontal)
    }
}

private struct BalanceIndicator: View {
    let balance: Int
    
    var body: some View {
        HStack {
            Text(String(balance))
            Image(uiImage: UIImage.iconEmerald)
        }
            .font(.callout)
            .padding(.vertical, 8)
            .padding(.horizontal, 18)
            .background(Color(uiColor: Constants.Colors.purple ?? .purple))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

private struct BonusMenuItem: View {
    let title: String
    let image: Image
    
    var body: some View {
        HStack {
            image
            Text(title)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    BonusView(viewModel: MockBonusViewModel())
}

class MockBonusViewModel: BonusViewModel {
    var balance: Int = 100
}
