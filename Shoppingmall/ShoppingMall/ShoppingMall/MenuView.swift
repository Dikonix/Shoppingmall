//
//  MenuView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 13.08.2024.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                MenuHeader()
                
                NavigationLink {
                    MenuNewsView(viewModel: NewsWithPromotionsViewModel(menuTitle: Constants.Text.menuViewNewsAndEventsTitle))
                } label: {
                    MenuItem(
                        title: Constants.Text.menuViewNewsAndEventsTitle,
                        image: Image(systemName: "gift")
                    )
                }
                
                NavigationLink {
                    MapView()
                } label: {
                    MenuItem(
                        title: Constants.Text.menuViewMapsTitle,
                        image: Image(systemName: "map")
                    )
                }
                
                NavigationLink {
                    SettingsView(logoutViewModel: LogoutViewModel())
                } label: {
                    MenuItem(
                        title: Constants.Text.menuViewSettingsTitle,
                        image: Image(systemName: "gearshape")
                    )
                }
                
                NavigationLink {
                    AppFeedbackView()
                } label: {
                    MenuItem(
                        title: Constants.Text.menuViewAboutAppTitle,
                        image: Image(systemName: "info.circle")
                    )
                }
            }
        }
    }
}

private struct MenuHeader: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text(Constants.Text.menu)
                .font(.title)
                .padding(.bottom)
            
            Text(Constants.Text.menuViewAbout + " ShoppingMall")
                .font(.headline)
        }
        .padding(.vertical, 24)
        .padding(.horizontal)
    }
}

private struct MenuItem: View {
    let title: String
    let image: Image
    
    var body: some View {
        HStack {
            image
            Text(title)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding()
    }
}

#Preview {
    MenuView()
}
