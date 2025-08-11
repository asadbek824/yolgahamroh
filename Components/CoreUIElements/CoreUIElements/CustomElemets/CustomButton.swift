//
//  CustomButton.swift
//  CoreUIElements
//
//  Created by Yo'ldoshev Asadbek on 04/08/2025.
//

import SwiftUI

public struct CustomGlassButton: View {
    public let title: String
    public let icon: String?
    public let cornerRadius: CGFloat
    public let action: () -> Void
    public let foregroundColor: Color

    public init(
        title: String,
        icon: String? = nil,
        cornerRadius: CGFloat = 16,
        foregroundColor: Color = .primary, // <— адаптивный по умолчанию
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.cornerRadius = cornerRadius
        self.foregroundColor = foregroundColor
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.headline)
                }
                Text(title)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        }
        .foregroundColor(foregroundColor)
    }
}
