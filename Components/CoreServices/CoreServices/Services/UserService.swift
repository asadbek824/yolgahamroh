//
//  UserService.swift
//  CoreServices
//
//  Created by Yo'ldoshev Asadbek on 13/08/2025.
//

import CoreModels
import CoreStorage
import Combine
import Foundation

public final class UserService: ObservableObject {
    public static let shared = UserService()

    private let storage = CoreStore.default
    private let userKey   = "user.data"
    private let avatarKey = "user.avatar.data"

    @Published public private(set) var currentUser: UserModel?
    @Published public private(set) var avatarData: Data?

    private init() {
        self.currentUser = storage.load(UserModel.self, forKey: userKey)
        self.avatarData  = storage.load(Data.self, forKey: avatarKey, using: DataTransformer().any)
    }

    public func updateUser(_ user: UserModel) {
        currentUser = user
        try? storage.save(user, forKey: userKey)
    }

    public func updateName(_ name: String) {
        var u = currentUser ?? UserModel(name: "", email: "", telephoneNumber: "")
        u.name = name
        updateUser(u)
    }

    public func updateEmail(_ email: String) {
        var u = currentUser ?? UserModel(name: "", email: "", telephoneNumber: "")
        u.email = email
        updateUser(u)
    }

    public func updatePhone(_ phone: String) {
        var u = currentUser ?? UserModel(name: "", email: "", telephoneNumber: "")
        u.telephoneNumber = phone
        updateUser(u)
    }

    public func updateAvatarData(_ data: Data?) {
        avatarData = data
        if let data {
            try? storage.save(data, forKey: avatarKey, using: DataTransformer().any)
        } else {
            storage.remove(avatarKey)
        }
    }

    public func clearUser() {
        currentUser = nil
        avatarData = nil
        storage.remove(userKey)
        storage.remove(avatarKey)
    }
}
