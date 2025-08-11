//
//  AppLanguage.swift
//  CoreServices
//
//  Created by Yo'ldoshev Asadbek on 04/08/2025.
//

import Foundation

public enum AppLanguage: String, CaseIterable {
    case en = "en"
    case uz = "uz"
    case ru = "ru"

    public var displayName: String {
        switch self {
        case .en: return "English"
        case .uz: return "O‘zbekcha"
        case .ru: return "Русский"
        }
    }
}
