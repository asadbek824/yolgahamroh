//
//  ProfileContentView.swift
//  Profile
//
//  Created by Ilnar Isakov on 12.08.2025.
//

import SwiftUI
import CoreUIElements

public struct ProfileContentView: View {
    @ObservedObject var viewModel: ProfileViewModel

    public var body: some View {
        contentView()
    }
}

extension ProfileContentView {
    func contentView() -> some View {
        NavigationStack(path: $viewModel.path) {
            List {
                Section {
                    ProfileHeaderView(
                        user: viewModel.user,
                        avatarData: viewModel.avatarData,
                        onAvatarTap: { viewModel.onAvatarTap() }
                    )
                    .listRowBackground(Color.clear)
                }

                ForEach(viewModel.sections) { section in
                    Section {
                        ForEach(section.rows) { row in
                            ProfileRow(model: row) {
                                viewModel.handleTap(on: row)
                            }
                        }
                    } header: {
                        if let title = section.header {
                            Text(title).textCase(nil)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle(viewModel.navTitle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: ProfileRoute.self) { route in
                switch route {
                case .editProfile:
                    EditProfileView()
                        .navigationTitle("Edit Profile")
                        .navigationBarTitleDisplayMode(.inline)

                case .paymentMethods:
                    PaymentMethodsView()
                        .navigationTitle("Payment methods")
                        .navigationBarTitleDisplayMode(.inline)

                case .notifications:
                    NotificationsSettingsView()
                        .navigationTitle("Notifications")
                        .navigationBarTitleDisplayMode(.inline)

                case .rideHistory:
                    TripsListView()
                        .navigationTitle("My Trips")
                        .navigationBarTitleDisplayMode(.inline)

                case .support:
                    HelpView()
                        .navigationTitle("Help")
                        .navigationBarTitleDisplayMode(.inline)

                case .logout:
                    EmptyView()
                }
            }
        }
        .photosPicker(
            isPresented: $viewModel.showPicker,
            selection: $viewModel.pickedItem,
            matching: .images
        )
        .onChange(of: viewModel.pickedItem) { _ in
            Task { await viewModel.handlePickedItem() }
        }
        .baseAlert(
            "Доступ к фото отключён",
            isPresented: $viewModel.showPermissionAlert,
            style: .warning,
            message: "Разрешите доступ к Фото, чтобы выбрать аватар.",
            primary: .init("Открыть настройки", kind: .primary) { viewModel.openSystemSettings() },
            secondary: .init("Отмена", kind: .secondary) { }
        )
        .baseAlert(
            "Выйти из аккаунта?",
            isPresented: $viewModel.showLogoutAlert,
            style: .warning,
            message: "Вы сможете войти снова в любой момент.",
            primary: .init("Выйти", kind: .destructive) { },
            secondary: .init("Отмена", kind: .secondary) { }
        )
    }
}
