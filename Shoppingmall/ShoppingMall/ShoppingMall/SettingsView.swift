//
//  SetingsView.swift
//  ShoppingMall
//
//  Created by Diana Brik on 07.11.2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var isAuthenticated = AuthManager.isAuthenticated
    @State private var promotionsEnabled = true
    @State private var kidsEventsEnabled = false
    @State private var mallEventsEnabled = true
    @ObservedObject private var logoutViewModel: LogoutViewModel
    @State private var showNoAuth = false
    
    let purpleColor = Color(uiColor: Constants.Colors.purple ?? .purple)
    let mobileDeviceId = DeviceManager.shared.mobileDeviceId ?? ""
    
    init(logoutViewModel: LogoutViewModel) {
        self.logoutViewModel = logoutViewModel
    }
    
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading, spacing: 16) {
                if showNoAuth == false {
                    Text(Constants.Text.settingsViewNotifications)
                        .font(.headline)
                    
                    Toggle(Constants.Text.settingsViewPromotionsInStores, isOn: $promotionsEnabled)
                        .toggleStyle(SwitchToggleStyle(tint: purpleColor))
                    
                    Divider()
                    
                    Toggle(Constants.Text.settingsViewChildrenEvents, isOn: $kidsEventsEnabled)
                        .toggleStyle(SwitchToggleStyle(tint: purpleColor))
                    
                    Divider()
                    
                    Toggle(Constants.Text.settingsViewEventsInTheMall, isOn: $mallEventsEnabled)
                        .toggleStyle(SwitchToggleStyle(tint: purpleColor))
                    
                    Divider()
                    
                    if isAuthenticated {
                        NavigationLink(destination: ProfileView(viewModel: ProfileViewModelImpl(mobileDeviceId: mobileDeviceId))) {
                            Label(Constants.Text.settingsViewProfileData, systemImage: "person.circle")
                                .foregroundColor(purpleColor)
                        }
                        
                        Divider()
                        
                        Button(action: {
                            isAuthenticated = false
                            AuthManager.logOut()
                            logoutViewModel.logout()
                        }) {
                            Label(Constants.Text.settingsViewLogoutOfProfile, systemImage: "arrowshape.turn.up.left")
                                .foregroundColor(purpleColor)
                        }
                    } else {
                        Button(action: {
                            showNoAuth = true
                        }) {
                            Label(Constants.Text.settingsViewAuthorization, systemImage: "arrowshape.turn.up.left")
                                .foregroundColor(purpleColor)
                        }
                    }
                } else {
                    NoAuthView()
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle(Constants.Text.menuViewSettingsTitle)
            .onAppear {
                isAuthenticated = AuthManager.isAuthenticated
                if isAuthenticated {
                    showNoAuth = false
                }
            }
        }
    }
}

#Preview {
    SettingsView(logoutViewModel: LogoutViewModel())
}
