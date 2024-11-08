//
//  TabBarRouter.swift
//  ShoppingMall
//
//  Created by Diana Brik on 13.08.2024.
//

import SwiftUI

struct TabBarRouter: View {
    @Binding var shouldShowOnboarding: Bool
    
    var body: some View {
        TabView {
            NavigationStack {
                HomeView(homeViewModel: HomeViewModelImpl())
            }
            .tabItem {
                Label(Constants.Text.home, systemImage: "house")
            }
            
            NavigationStack {
                CatalogView(viewModel: CatalogViewModelImpl())
                    .navigationDestination(for: CategoryItemDTO.self) { categoryItem in
                        DetailsView(viewModel: ObjectDetailsViewModel(shopId: categoryItem.id), promotionViewModel: PromotionViewModelImpl(shopId: categoryItem.id))
                    }
                    .navigationDestination(for: CatalogItem.self) { item in
                        CatalogDetailView(viewModel: CatalogDetailViewModel(slug: item.slug, catalogDetailTitle: item.title))
                    }
                
            }
            .tabItem {
                Label(Constants.Text.catalog, systemImage: "cart")
            }
            
            NavigationStack {
                BonusView(viewModel: MockBonusViewModel())
            }
            .tabItem {
                Label(Constants.Text.bonus, systemImage: "gift")
            }
            
            NavigationStack {
                MenuView()
            }
            .tabItem {
                Label(Constants.Text.menu, systemImage: "gearshape")
            }
        }
    }
}
