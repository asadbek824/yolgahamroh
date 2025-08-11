//
//  UserDefaultsService.swift
//  CoreServices
//
//  Created by Yo'ldoshev Asadbek on 04/08/2025.
//

import Foundation

public protocol UserDefaultsServiceProtocol {
    func getString(forKey key: String) -> String?
    func setString(_ value: String, forKey key: String)
    func removeValue(forKey key: String)
}

public final class UserDefaultsService: UserDefaultsServiceProtocol {

    public static let shared = UserDefaultsService()
    private let defaults = UserDefaults.standard

    private init() {}

    public func getString(forKey key: String) -> String? {
        defaults.string(forKey: key)
    }

    public func setString(_ value: String, forKey key: String) {
        defaults.set(value, forKey: key)
    }

    public func removeValue(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}
