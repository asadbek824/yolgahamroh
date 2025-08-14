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
        contentView
    }
}

extension ProfileContentView {
    private var contentView: some View {
        NavigationView {
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
                            ProfileRow(model: row) { }
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
        }
        .photosPicker(
            isPresented: $viewModel.showPicker,
            selection: $viewModel.pickedItem,
            matching: .images
        )
        .onChange(of: viewModel.pickedItem) { _ in
            Task { await viewModel.handlePickedItem() }
        }
    }
}
