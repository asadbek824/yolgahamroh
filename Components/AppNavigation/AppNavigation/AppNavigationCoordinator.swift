//
//  AppNavigationCoordinator.swift
//  AppNavigation
//
//  Created by Yo'ldoshev Asadbek on 04/08/2025.
//

import SwiftUI

final class AppNavigationCoordinator: ObservableObject {
    enum Tab {
        case home, profile
    }

    @Published var selectedTab: Tab = .home

    func openTab(_ tab: Tab) {
        selectedTab = tab
    }
}
