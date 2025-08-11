//
//  AppRootView.swift
//  AppNavigation
//
//  Created by Yo'ldoshev Asadbek on 04/08/2025.
//

import SwiftUI
import Home

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

            Text("Поездки")
                .tabItem {
                    Label("Поездки", systemImage: "car")
                }
                .tag(AppNavigationCoordinator.Tab.trips)

            Text("Избранное")
                .tabItem {
                    Label("Избранное", systemImage: "heart")
                }
                .tag(AppNavigationCoordinator.Tab.favorites)

            Text("Профиль")
                .tabItem {
                    Label("Профиль", systemImage: "person")
                }
                .tag(AppNavigationCoordinator.Tab.profile)
        }
        .environmentObject(coordinator)
    }
}
