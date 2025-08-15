//
//  AppThemeStorage.swift
//  CoreStorage
//
//  Created by Yo'ldoshev Asadbek on 15/08/2025.
//

import CoreModels

public struct AppThemeStorage {
    private static let key = "app.theme"

    @StoredCodable(key: key, default: AppTheme.defaultValue())
    public static var current: AppTheme

    public static func exists() -> Bool {
        CoreStore.default.contains(key)
    }
}
