//
//  ProfileScreen.swift
//  Profile
//
//  Created by Yo'ldoshev Asadbek on 15/08/2025.
//

import SwiftUI
import PhotosUI
import CoreUIElements

struct ProfileScreen: View {
    @ObservedObject var viewModel: ProfileViewModel
    @ObservedObject var coordinator: ProfileCoordinator

    @State private var pickerItem: PhotosPickerItem?

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ZStack {
                BackgroundView()
                List {
                    headerSection
                    sectionsList
                }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .overlay(GeometryReader { proxy in
                    Color.clear
                        .preference(key: ScrollOffsetPreferenceKey.self,
                                    value: proxy.frame(in: .named("scroll")).minY)
                })
            }
            .coordinateSpace(name: "scroll")
            .navigationTitle(viewModel.localizationService.navTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationDestination(for: ProfileRoute.self) { route in
                coordinator.destination(for: route)
            }
        }
        .photosPicker(
            isPresented: Binding(
                get: { viewModel.state.showPicker },
                set: { presented in viewModel.send(.setPickerPresented(presented)) }
            ),
            selection: $pickerItem,
            matching: .images
        )
        .onChange(of: pickerItem) { item in
            viewModel.send(.pickedItem(item))
            pickerItem = nil
        }
        .onAppear { viewModel.send(.onAppear) }
        .baseAlert(
            viewModel.localizationService.photoPermissionTitle,
            isPresented: Binding(
                get: { viewModel.state.showPermissionAlert },
                set: { shown in viewModel.send(.setPermissionAlert(shown)) }
            ),
            style: .warning,
            message: viewModel.localizationService.photoPermissionMessage,
            primary: .init(
                viewModel.localizationService.openSettingsButton,
                kind: .primary
            ) { viewModel.send(.openSettings) },
            secondary: .init(
                viewModel.localizationService.cancelButton,
                kind: .secondary
            ) {  }
        )
        .baseAlert(
            viewModel.localizationService.logoutTitle,
            isPresented: Binding(
                get: { viewModel.state.showLogoutAlert },
                set: { shown in viewModel.send(.setLogoutAlert(shown)) }
            ),
            style: .warning,
            message: viewModel.localizationService.logoutMessage,
            primary: .init(
                viewModel.localizationService.singOut,
                kind: .destructive
            ) {
                viewModel.send(.confirmLogout)
            },
            secondary: .init(
                viewModel.localizationService.cancelButton,
                kind: .secondary
            ) { }
        )
    }

    private var headerSection: some View {
        Section {
            ProfileHeaderView(
                user: viewModel.state.user,
                avatarData: viewModel.state.avatarData,
                onAvatarTap: { viewModel.send(.headerAvatarTapped) }
            )
            .listRowBackground(Color.clear)
        }
    }

    private var sectionsList: some View {
        ForEach(viewModel.sections) { section in
            Section {
                ForEach(section.rows) { row in
                    ProfileRow(model: row) {
                        viewModel.send(.tapRow(row))
                    }
                }
            } header: {
                if let title = section.header {
                    Text(title).textCase(nil)
                }
            }
        }
    }
}
