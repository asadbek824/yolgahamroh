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
            .navigationTitle(viewModel.localizationService.navTitle)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: ProfileRoute.self) { route in
                switch route {
                case .editProfile:
                    EditProfileView()
                        .navigationTitle(viewModel.localizationService.editProfile)
                        .navigationBarTitleDisplayMode(.inline)

                case .paymentMethods:
                    PaymentMethodsView()
                        .navigationTitle(viewModel.localizationService.paymentMethods)
                        .navigationBarTitleDisplayMode(.inline)

                case .notifications:
                    NotificationsSettingsView()
                        .navigationTitle(viewModel.localizationService.notifications)
                        .navigationBarTitleDisplayMode(.inline)

                case .rideHistory:
                    TripsListView()
                        .navigationTitle(viewModel.localizationService.rideHistory)
                        .navigationBarTitleDisplayMode(.inline)
                
                case .languageChange:
                    LanguageChangeView()
                        .navigationTitle(viewModel.localizationService.translatedTitle)
                        .navigationBarTitleDisplayMode(.inline)

                case .support:
                    HelpView()
                        .navigationTitle(viewModel.localizationService.support)
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
            viewModel.localizationService.photoPermissionTitle,
            isPresented: $viewModel.showPermissionAlert,
            style: .warning,
            message: viewModel.localizationService.photoPermissionMessage,
            primary: .init(
                viewModel.localizationService.openSettingsButton,
                kind: .primary
            ) { viewModel.openSystemSettings() },
            secondary: .init(
                viewModel.localizationService.cancelButton,
                kind: .secondary
            ) { }
        )
        .baseAlert(
            viewModel.localizationService.logoutTitle,
            isPresented: $viewModel.showLogoutAlert,
            style: .warning,
            message: viewModel.localizationService.logoutMessage,
            primary: .init(viewModel.localizationService.singOut, kind: .destructive) { },
            secondary: .init(viewModel.localizationService.cancelButton, kind: .secondary) { }
        )
    }
}
