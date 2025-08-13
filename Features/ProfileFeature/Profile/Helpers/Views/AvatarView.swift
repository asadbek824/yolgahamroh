//
//  AvatarView.swift
//  Profile
//
//  Created by Ilnar Isakov on 13.08.2025.
//

import SwiftUI

struct AvatarView: View {
    let url: URL?
    
    var body: some View {
        Group {
            if let url {
                AsyncImage(url: url, transaction: .init(animation: .easeInOut)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView().progressViewStyle(.circular)
                    case .success(let image):
                        image.resizable().scaledToFill()
                    default:
                        placeholder
                    }
                }
            } else {
                placeholder
            }
        }
        .clipShape(Circle())
        .overlay(Circle().strokeBorder(.quaternary, lineWidth: 1))
        .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 4)
        .accessibilityHidden(true)
    }
    
    private var placeholder: some View {
        ZStack {
            Circle().fill(.ultraThinMaterial)
            Image(systemName: "person.fill")
                .font(.system(size: 36))
                .foregroundStyle(.secondary)
        }
    }
}
