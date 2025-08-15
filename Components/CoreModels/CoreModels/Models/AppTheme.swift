//
//  AppTheme.swift
//  CoreModels
//
//  Created by Yo'ldoshev Asadbek on 15/08/2025.
//

import Foundation

public enum AppTheme: String, Codable, CaseIterable, Identifiable {
    case system, light, dark
    
    public var id: String { rawValue }

    public static func defaultValue() -> AppTheme {
        return .system
    }
}
