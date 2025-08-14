//
//  AppLanguage.swift
//  CoreModels
//
//  Created by Yo'ldoshev Asadbek on 14/08/2025.
//

import Foundation

public enum AppLanguage: String, Codable, CaseIterable, Identifiable {
    case en, ru, uz
    public var id: String { rawValue }

    public var localeIdentifier: String {
        switch self {
        case .en: return "en"
        case .ru: return "ru"
        case .uz: return "uz"
        }
    }

    static func fromSystemCode(_ code: String) -> AppLanguage {
        let lower = code.lowercased()
        if lower.hasPrefix("ru") { return .ru }
        if lower.hasPrefix("uz") { return .uz }
        return .en
    }

    public static func systemDefault() -> AppLanguage {
        let first = Locale.preferredLanguages.first
            ?? Locale.current.identifier
        return AppLanguage.fromSystemCode(first)
    }
}
