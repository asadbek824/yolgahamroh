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
    
    init() {
        LanguageManager.shared.bootstrap()
    }
    
    var body: some Scene {
        WindowGroup {
            AppRootView()
                .environmentObject(lang)
                .environment(\.locale, Locale(identifier: lang.language.localeIdentifier))
        }
    }
}
