//
//  AppRootView.swift
//  AppNavigation
//
//  Created by Yo'ldoshev Asadbek on 04/08/2025.
//

import SwiftUI
import Home
import Profile
import DesignSystem

public struct AppRootView: View {
    @StateObject private var coordinator = AppNavigationCoordinator()
    
    public init() {  }

    public var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            HomeView()
                .tabItem {
                    Label("Главная", systemImage: "house")
                }
                .tag(AppNavigationCoordinator.Tab.home)


            ProfileAssembly().assemble()
                .tabItem {
                    Label("Профиль", systemImage: "person")
                }
                .tag(AppNavigationCoordinator.Tab.profile)
        }
        .environmentObject(coordinator)
    }
}
