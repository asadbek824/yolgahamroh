//
//  BundleFinder.swift
//  HomeDesignSystem
//
//  Created by Yo'ldoshev Asadbek on 04/08/2025.
//

import Foundation

final class BundleFinder {
    static func localized(_ key: String) -> String {
        let bundle = Bundle(for: BundleFinder.self)
        return NSLocalizedString(
            key,
            tableName: nil,
            bundle: bundle,
            value: "**\(key)**",
            comment: ""
        )
    }
}
