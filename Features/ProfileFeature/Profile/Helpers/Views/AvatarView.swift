//
//  AvatarView.swift
//  Profile
//
//  Created by Ilnar Isakov on 13.08.2025.
//

import SwiftUI

struct AvatarView: View {
    let data: Data?
    var onTap: () -> Void

    var body: some View {
        Group {
            if let data, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage).resizable().scaledToFill()
            } else {
                ZStack {
                    Circle().fill(.ultraThinMaterial)
                    Image(systemName: "person.fill")
                        .font(.system(size: 36))
                        .foregroundStyle(.secondary)
                }
            }
        }
        .clipShape(Circle())
        .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 4)
        .contentShape(Circle())
        .onTapGesture(perform: onTap)
    }
}

