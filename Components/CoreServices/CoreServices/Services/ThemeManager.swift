//
//  ThemeManager.swift
//  CoreServices
//
//  Created by Yo'ldoshev Asadbek on 15/08/2025.
//

import SwiftUI
import Combine
import CoreStorage
import CoreModels

public final class ThemeManager: ObservableObject {
    public static let shared = ThemeManager()

    @Published public private(set) var theme: AppTheme = .system

    private init() {}

    public func bootstrap() {
        if !AppThemeStorage.exists() {
            AppThemeStorage.current = .system
        }
        theme = AppThemeStorage.current
    }

    public func set(_ theme: AppTheme) {
        guard theme != self.theme else { return }
        AppThemeStorage.current = theme
        self.theme = theme
    }

    /// Returns correct ColorScheme to apply
    public var colorScheme: ColorScheme? {
        switch theme {
        case .system: return nil
        case .light:  return .light
        case .dark:   return .dark
        @unknown default: return nil
        }
    }
}
