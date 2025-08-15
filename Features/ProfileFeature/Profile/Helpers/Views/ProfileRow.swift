//
//  ProfileRowView.swift
//  Profile
//
//  Created by Ilnar Isakov on 13.08.2025.
//

import SwiftUI

struct ProfileRow: View {
    let model: ProfileRowModel
    var action: () -> Void

    var body: some View {
        Button(role: model.role, action: action) {
            HStack(spacing: 12) {
                ZStack {
                    Circle().fill((model.tint ?? .accentColor).opacity(0.12))
                    Image(systemName: model.icon)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(model.tint ?? .accentColor)
                }
                .frame(width: 32, height: 32)
                .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: 2) {
                    Text(model.title)
                        .foregroundStyle(model.role == .destructive ? .red : .primary)
                    if let subtitle = model.subtitle {
                        Text(subtitle)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .lineLimit(2)
                    }
                }

                Spacer()
                if model.role != .destructive {
                    Image(systemName: "chevron.right")
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(.tertiary)
                        .accessibilityHidden(true)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(model.title)
    }
}
