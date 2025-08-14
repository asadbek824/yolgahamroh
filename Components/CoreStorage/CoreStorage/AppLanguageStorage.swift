//
//  AppLanguageStorage.swift
//  CoreStorage
//
//  Created by Yo'ldoshev Asadbek on 14/08/2025.
//

import Foundation
import CoreModels

public struct AppLanguageStorage {
    static let key = "app.language"

    @StoredCodable(key: key, default: AppLanguage.en)
    public static var current: AppLanguage

    public static func exists() -> Bool {
        CoreStore.default.contains(key)
    }
}
