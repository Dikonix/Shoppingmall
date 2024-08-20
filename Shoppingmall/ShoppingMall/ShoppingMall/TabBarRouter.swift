//
//  TabBarRouter.swift
//  ShoppingMall
//
//  Created by Diana Brik on 13.08.2024.
//

import SwiftUI

struct TabBarRouter: View {
    @StateObject var router: Router
    @State private var selectedTab: Tab = .home
    
    init(shouldShowOnboarding: Binding<Bool>) {
        _router = StateObject(wrappedValue: Router(shouldShowOnboarding: shouldShowOnboarding))
    }
    
    enum Tab: Int, CaseIterable {
        case home, catalog, bonus, menu
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                NavigationStack(path: $router.homePath) {
                    HomeView()
                        .navigationDestination(for: Router.Route.self) { route in
                            router.view(for: route)
                        }
                }
                .tag(Tab.home)

                NavigationStack(path: $router.catalogPath) {
                    CatalogView()
                        .navigationDestination(for: Router.Route.self) { route in
                            router.view(for: route)
                        }
                }
                .tag(Tab.catalog)

                NavigationStack(path: $router.bonusPath) {
                    BonusView()
                        .navigationDestination(for: Router.Route.self) { route in
                            router.view(for: route)
                        }
                }
                .tag(Tab.bonus)

                NavigationStack(path: $router.menuPath) {
                    MenuView()
                        .navigationDestination(for: Router.Route.self) { route in
                            router.view(for: route)
                        }
                }
                .tag(Tab.menu)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            customTabBar
        }
        .environmentObject(router)
    }

    private var customTabBar: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(Color.white)
                .ignoresSafeArea(edges: .bottom)
                .frame(height: 69)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 0)

            HStack(spacing: 5) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    tabBarItem(tab: tab)
                    
                    if tab != .menu {
                        Divider()
                            .frame(width: 4, height: 30)
                            .background(Color.gray.opacity(0.1))
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.top, 25)
        }
    }

    private func tabBarItem(tab: Tab) -> some View {
        let icon: UIImage
        let title: String
        let selectedColor: Color = Color(uiColor: Constants.Colors.purple ?? .purple)

        switch tab {
        case .home:
            icon = UIImage.iconsHome
            title = Constants.Text.home
        case .catalog:
            icon = UIImage.iconsCatalog
            title = Constants.Text.catalog
        case .bonus:
            icon = UIImage.iconsBonus
            title = Constants.Text.bonus
        case .menu:
            icon = UIImage.iconsMenu
            title = Constants.Text.menu
        }

        return Button(action: {
            selectedTab = tab
        }) {
            VStack {
                Image(uiImage: icon)
                    .renderingMode(.template)
                    .foregroundColor(selectedTab == tab ? selectedColor : .gray)

                Text(title)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(selectedTab == tab ? selectedColor : .gray)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
