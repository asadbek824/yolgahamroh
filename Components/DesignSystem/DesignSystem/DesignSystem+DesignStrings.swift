//
//  DesignSystem+DesignStrings.swift
//  DesignSystem
//
//  Created by Yo'ldoshev Asadbek on 04/08/2025.
//

import Foundation

public extension DesignSystemProvider {
    enum DesignSystemsStrings {
        public static func localized(_ key: String) -> String {
            let bundle = Bundle.designSystem
            return NSLocalizedString(key, bundle: bundle, comment: "")
        }
        public static var homeNavTitle: String { localized("home_nav_title") }
    }
}
