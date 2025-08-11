//
//  extentionToBundle.swift
//  DesignSystem
//
//  Created by Asadbek Yoldoshev on 4/27/25.
//

import Foundation

extension Bundle {
    static let designSystem: Bundle = {
        Bundle(for: DesignSystemProvider.self)
    }()
}
