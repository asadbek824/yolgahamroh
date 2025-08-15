//
//  ProfileHeaderView.swift
//  Profile
//
//  Created by Ilnar Isakov on 13.08.2025.
//

import SwiftUI
import CoreModels

struct ProfileHeaderView: View {
    let user: UserModel
    let avatarData: Data?
    var onAvatarTap: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            AvatarView(data: avatarData, onTap: onAvatarTap)
                .frame(width: 96, height: 96)
            VStack(spacing: 4) {
                Text(user.name).font(.title3.weight(.semibold))
                Text(user.email).font(.subheadline).foregroundStyle(.secondary)
                Text(user.telephoneNumber).font(.subheadline).foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
}
