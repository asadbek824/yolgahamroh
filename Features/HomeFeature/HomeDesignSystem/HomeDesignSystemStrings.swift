//
//  HomeDesignSystemStrings.swift
//  HomeDesignSystem
//
//  Created by Yo'ldoshev Asadbek on 01/08/2025.
//

import Foundation

public enum HomeDesignSystemStrings {
    public static func localized(_ key: String) -> String {
        let bundle = Bundle(for: HomeDesignSystem.self)
        return NSLocalizedString(
            key,
            tableName: nil,
            bundle: bundle,
            value: "**\(key)**",
            comment: ""
        )
    }
}
