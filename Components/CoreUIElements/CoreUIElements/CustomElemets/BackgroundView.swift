//
//  BackgroundView.swift
//  CoreUIElements
//
//  Created by Yo'ldoshev Asadbek on 15/08/2025.
//

import SwiftUI
import CoreServices

public struct BackgroundView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.colorScheme) private var scheme

    @State private var scrollOffsetY: CGFloat = 0

    public init() {}

    public var body: some View {
        GeometryReader { geo in
            image
                .scaleEffect(1.05)
                .offset(y: scrollOffsetY * -0.06)
                .overlay(gradientOverlay)
                .overlay(vignetteOverlay)
                .overlay(noiseOverlay.blendMode(.overlay))
                .ignoresSafeArea()
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { scrollOffsetY = $0 }
        }
    }

    private var image: some View {
        Group {
            switch themeManager.theme {
            case .dark:
                Image("backgroundImageNew_dark").resizable().scaledToFill()
            case .light:
                Image("backgroundImageNew_light").resizable().scaledToFill()
            default:
                (scheme == .dark
                 ? Image("backgroundImageNew_dark")
                 : Image("backgroundImageNew_light"))
                    .resizable().scaledToFill()
            }
        }
    }

    private var gradientOverlay: some View {
        LinearGradient(
            colors: scheme == .dark
                ? [Color.black.opacity(0.55), Color.black.opacity(0.35), Color.black.opacity(0.65)]
                : [Color.white.opacity(0.20), Color.white.opacity(0.05), Color.white.opacity(0.30)],
            startPoint: .top, endPoint: .bottom
        )
        .allowsHitTesting(false)
    }

    private var vignetteOverlay: some View {
        RadialGradient(
            gradient: Gradient(stops: [
                .init(color: .black.opacity(0.0), location: 0.65),
                .init(color: .black.opacity(scheme == .dark ? 0.35 : 0.15), location: 1.0)
            ]),
            center: .center,
            startRadius: 10,
            endRadius: 800
        )
        .allowsHitTesting(false)
    }

    private var noiseOverlay: some View {
        Image("noise")
            .resizable(resizingMode: .tile)
            .opacity(scheme == .dark ? 0.05 : 0.03)
            .allowsHitTesting(false)
    }
}

public struct ScrollOffsetPreferenceKey: PreferenceKey {
    public static var defaultValue: CGFloat = 0
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { value = nextValue() }
}

public extension View {
    func trackListScroll(_ y: CGFloat) -> some View {
        anchorPreference(key: ScrollOffsetPreferenceKey.self, value: .bounds) { _ in y }
    }
}
