//
//  BaseAlert.swift
//  CoreUIElements
//
//  Created by Yo'ldoshev Asadbek on 14/08/2025.
//

import SwiftUI
import UIKit

// MARK: - Public API
public struct BaseAlertAction {
    public enum Kind { case primary, secondary, destructive }
    public let title: String
    public let kind: Kind
    public let action: () -> Void

    public init(_ title: String, kind: Kind = .primary, action: @escaping () -> Void) {
        self.title = title
        self.kind = kind
        self.action = action
    }
}

public enum BaseAlertStyle: Equatable {
    case info
    case success
    case warning
    case error
    case custom(accent: Color, systemIcon: String?)

    var accent: Color {
        switch self {
        case .info:    return Color.blue
        case .success: return Color.green
        case .warning: return Color.orange
        case .error:   return Color.red
        case .custom(let accent, _): return accent
        }
    }

    var iconName: String? {
        switch self {
        case .info:    return "info.circle.fill"
        case .success: return "checkmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .error:   return "xmark.octagon.fill"
        case .custom(_, let name): return name
        }
    }
}

public extension View {
    /// Показывает кастомный алерт поверх контента.
    /// Пример:
    /// .baseAlert(
    ///   "Доступ к фото отключён",
    ///   isPresented: $show,
    ///   style: .warning,
    ///   message: "Разрешите доступ к Фото, чтобы выбрать аватар.",
    ///   primary: .init("Открыть настройки", kind: .primary) { openSettings() },
    ///   secondary: .init("Отмена", kind: .secondary) {}
    /// )
    func baseAlert(
        _ title: String,
        isPresented: Binding<Bool>,
        style: BaseAlertStyle = .info,
        message: String? = nil,
        primary: BaseAlertAction,
        secondary: BaseAlertAction? = nil
    ) -> some View {
        modifier(
            BaseAlertModifier(
                isPresented: isPresented,
                title: title,
                style: style,
                message: message,
                primary: primary,
                secondary: secondary
            )
        )
    }
}

// MARK: - Modifier
public struct BaseAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    let style: BaseAlertStyle
    let message: String?
    let primary: BaseAlertAction
    let secondary: BaseAlertAction?

    @State private var showCard = false

    public func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                Color.black.opacity(0.35)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }
                    .transition(.opacity)

                VStack(spacing: 18) {
                    if let icon = style.iconName {
                        Image(systemName: icon)
                            .font(.system(size: 36, weight: .semibold))
                            .foregroundStyle(style.accent)
                            .padding(.top, 6)
                    }

                    Text(title)
                        .font(.system(.title3, design: .rounded).weight(.semibold))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.primary)

                    if let message {
                        Text(message)
                            .font(.system(.body, design: .rounded))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 6)
                    }

                    VStack(spacing: 10) {
                        buttonView(for: primary)

                        if let secondary {
                            buttonView(for: secondary)
                        }
                    }
                    .padding(.top, 4)
                }
                .padding(20)
                .frame(maxWidth: 340)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                .shadow(color: .black.opacity(0.18), radius: 24, x: 0, y: 10)
                .scaleEffect(showCard ? 1 : 0.96)
                .opacity(showCard ? 1 : 0)
                .onAppear {
                    showCard = true
                    UINotificationFeedbackGenerator().notificationOccurred(.warning)
                }
                .onDisappear { showCard = false }
                .padding(.horizontal, 16)
                .transition(.opacity.combined(with: .scale(scale: 0.96)))
            }
        }
        .animation(.interactiveSpring(response: 0.28, dampingFraction: 0.9), value: isPresented)
    }

    @ViewBuilder
    private func buttonView(for action: BaseAlertAction) -> some View {
        Button {
            withAnimation { isPresented = false }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
                action.action()
            }
        } label: {
            switch action.kind {
            case .primary:
                Text(action.title)
                    .font(.system(.body, design: .rounded).weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(style.accent)
                    .foregroundStyle(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            case .secondary:
                Text(action.title)
                    .font(.system(.body, design: .rounded).weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .strokeBorder(.quaternary, lineWidth: 1)
                    )
                    .foregroundStyle(.primary)

            case .destructive:
                Text(action.title)
                    .font(.system(.body, design: .rounded).weight(.semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.red)
                    .foregroundStyle(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier("BaseAlertButton_\(action.title)")
    }
}
