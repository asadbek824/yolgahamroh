//
//  LanguageService.swift
//  CoreServices
//
//  Created by Yo'ldoshev Asadbek on 14/08/2025.
//

import CoreStorage
import CoreModels
import Combine
import Foundation

public final class LanguageManager: ObservableObject {
    public static let shared = LanguageManager()
    @Published public private(set) var language: AppLanguage = .en

    private init() {}

    public func bootstrap() {
        if !AppLanguageStorage.exists() {
            AppLanguageStorage.current = .systemDefault()
        }
        language = AppLanguageStorage.current
    }

    public func set(_ lang: AppLanguage) {
        guard lang != language else { return }
        AppLanguageStorage.current = lang
        language = lang
    }

    public func localized(_ key: String, from bundle: Bundle, table: String? = nil) -> String {
        guard
            let path = bundle.path(forResource: language.localeIdentifier, ofType: "lproj"),
            let langBundle = Bundle(path: path)
        else {
            return NSLocalizedString(key, tableName: table, bundle: bundle, comment: "")
        }
        return NSLocalizedString(key, tableName: table, bundle: langBundle, comment: "")
    }
}
