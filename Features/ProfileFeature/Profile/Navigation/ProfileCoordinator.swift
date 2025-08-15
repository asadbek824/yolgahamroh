//
//  ProfileCoordinator.swift
//  Profile
//
//  Created by Yo'ldoshev Asadbek on 15/08/2025.
//

import SwiftUI

@MainActor
protocol ProfileNavigating: AnyObject {
    func navigate(to route: ProfileRoute)
    func pop()
}

@MainActor
final class ProfileCoordinator: ObservableObject, ProfileNavigating {
    @Published var path = NavigationPath()
    private let localization: ProfileLocalizationServiceProtocol

    init(localization: ProfileLocalizationServiceProtocol) {
        self.localization = localization
    }

    func navigate(to route: ProfileRoute) {
        guard route != .logout else { return }
        path.append(route)
    }

    func pop() { path.removeLast() }

    @ViewBuilder
    func destination(for route: ProfileRoute) -> some View {
        switch route {
        case .editProfile:
            EditProfileView()
                .navigationTitle(localization.editProfile)
                .navigationBarTitleDisplayMode(.inline)

        case .paymentMethods:
            PaymentMethodsView()
                .navigationTitle(localization.paymentMethods)
                .navigationBarTitleDisplayMode(.inline)

        case .notifications:
            NotificationsSettingsView()
                .navigationTitle(localization.notifications)
                .navigationBarTitleDisplayMode(.inline)

        case .rideHistory:
            TripsListView()
                .navigationTitle(localization.rideHistory)
                .navigationBarTitleDisplayMode(.inline)

        case .support:
            HelpView()
                .navigationTitle(localization.support)
                .navigationBarTitleDisplayMode(.inline)

        case .logout:
            EmptyView()
        }
    }
}
