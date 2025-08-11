//
//  LanguageService.swift
//  CoreServices
//
//  Created by Yo'ldoshev Asadbek on 04/08/2025.
//

import Foundation

public final class LanguageService {

    public static let shared = LanguageService()

    private let userDefaults: UserDefaultsServiceProtocol
    private let languageKey = "selectedAppLanguage"

    public init(userDefaults: UserDefaultsServiceProtocol = UserDefaultsService.shared) {
        self.userDefaults = userDefaults
    }

    public var currentLanguage: AppLanguage {
        if let stored = userDefaults.getString(forKey: languageKey),
           let lang = AppLanguage(rawValue: stored) {
            return lang
        }

        let systemLangCode = Locale.preferredLanguages.first?.prefix(2) ?? "uz"
        return AppLanguage(rawValue: String(systemLangCode)) ?? .ru
    }

    public func setLanguage(_ language: AppLanguage) {
        userDefaults.setString(language.rawValue, forKey: languageKey)
    }

    public func resetToSystemLanguage() {
        userDefaults.removeValue(forKey: languageKey)
    }
}
