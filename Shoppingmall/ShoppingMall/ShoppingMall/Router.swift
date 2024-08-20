//
//  Router.swift
//  ShoppingMall
//
//  Created by Diana Brik on 31.07.2024.
//

import SwiftUI

//struct RouterView<Content: View>: View {
//    @StateObject var router: Router
//    private let content: Content
//    
//    init(shouldShowOnboarding: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
//        _router = StateObject(wrappedValue: Router(shouldShowOnboarding: shouldShowOnboarding))
//        self.content = content()
//    }
//    
//    var body: some View {
//        NavigationStack(path: $router.path) {
//            content
//                .navigationDestination(for: Router.Route.self) { route in
//                    router.view(for: route)
//                }
//        }
//        .environmentObject(router)
//    }
//}

class Router: ObservableObject {
    @Binding var shouldShowOnboarding: Bool
    
    init(shouldShowOnboarding: Binding<Bool>) {
        _shouldShowOnboarding = shouldShowOnboarding
    }
    
    enum Route: Hashable {
        case onboardingView
    }
    
//    @Published var path: NavigationPath = NavigationPath()
    @Published var homePath: NavigationPath = NavigationPath()
    @Published var catalogPath: NavigationPath = NavigationPath()
    @Published var bonusPath: NavigationPath = NavigationPath()
    @Published var menuPath: NavigationPath = NavigationPath()
    
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .onboardingView:
            OnboardingView(shouldShowOnboarding: $shouldShowOnboarding)
        }
    }
    
//    func navigateTo(_ appRoute: Route) {
//        path.append(appRoute)
//    }
//    
//    func navigateBack() {
//        path.removeLast()
//    }
//    
//    func popToRoot() {
//        path.removeLast(path.count)
//    }
    func navigateTo(_ route: Route, in tab: TabBarRouter.Tab) {
            switch tab {
            case .home:
                homePath.append(route)
            case .catalog:
                catalogPath.append(route)
            case .bonus:
                bonusPath.append(route)
            case .menu:
                menuPath.append(route)
            }
        }
        
        func navigateBack(in tab: TabBarRouter.Tab) {
            switch tab {
            case .home:
                homePath.removeLast()
            case .catalog:
                catalogPath.removeLast()
            case .bonus:
                bonusPath.removeLast()
            case .menu:
                menuPath.removeLast()
            }
        }
        
        func popToRoot(in tab: TabBarRouter.Tab) {
            switch tab {
            case .home:
                homePath.removeLast(homePath.count)
            case .catalog:
                catalogPath.removeLast(catalogPath.count)
            case .bonus:
                bonusPath.removeLast(bonusPath.count)
            case .menu:
                menuPath.removeLast(menuPath.count)
            }
        }
}
