//
//  ProfileContentView.swift
//  Profile
//
//  Created by Ilnar Isakov on 12.08.2025.
//

import SwiftUI
import CoreUIElements

public struct ProfileContentView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var path: [ProfileRoute] = []
    
    public init() {}
    
    public var body: some View {
        contentView
    }
}

extension ProfileContentView {
    private var contentView: some View {
        NavigationView {
            List {
                Section {
                    ProfileHeaderView(user: viewModel.user)
                        .listRowBackground(Color.clear)
                }
                ForEach(viewModel.sections) { section in
                    Section {
                        ForEach(section.rows) { row in
                            ProfileRow(model: row) {
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
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .background(backgroundImage)
        }
    }
    
    private var backgroundImage: some View {
        GeometryReader { geometry in
            ZStack {
                Image("uzbek_background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.white.opacity(0.9))
                
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.black.opacity(0.5),
                        Color.clear
                    ]),
                    startPoint: .top,
                    endPoint: .center
                )
                
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.clear,
                        Color.black.opacity(0.4)
                    ]),
                    startPoint: .center,
                    endPoint: .bottom
                )
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ProfileContentView()
}
