//
//  ProfileHeaderView.swift
//  Profile
//
//  Created by Ilnar Isakov on 13.08.2025.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: UserModel
    
    var body: some View {
        VStack(spacing: 12) {
            AvatarView(url: user.avatarURL).frame(width: 96, height: 96)
            VStack(spacing: 4) {
                Text(user.name)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                Text(user.email)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .textSelection(.enabled)
                    .accessibilityLabel("Email \(user.email)")
                Text(user.telephoneNumber)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .textSelection(.enabled)
                    .accessibilityLabel("Phone \(user.telephoneNumber)")
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .accessibilityElement(children: .contain)
        .accessibilityHint("Tap to edit your profile")
    }
}
