//
//  YolgaHamrohApp.swift
//  YolgaHamroh
//
//  Created by Yo'ldoshev Asadbek on 01/08/2025.
//

import SwiftUI
import AppNavigation
import CoreServices

@main
struct YolgaHamrohApp: App {
    @StateObject private var lang = LanguageManager.shared
    @StateObject private var theme = ThemeManager.shared
    
    var body: some Scene {
        WindowGroup {
            AppRootView()
                .environmentObject(lang)
                .environmentObject(theme)
                .preferredColorScheme(theme.colorScheme)
                .environment(\.locale, Locale(identifier: lang.language.localeIdentifier))
                .task {
                    lang.bootstrap()
                    theme.bootstrap()
                }
        }
    }
}
