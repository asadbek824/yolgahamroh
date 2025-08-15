//
//  UserRepositoryBridge.swift
//  Profile
//
//  Created by Yo'ldoshev Asadbek on 15/08/2025.
//

import Foundation
import CoreModels
import CoreServices

final class UserRepository: UserRepositoryProtocol {
    static let shared = UserRepository()
    private let service = UserService.shared

    var currentUser: UserModel? { service.currentUser }
    var avatarData: Data? { service.avatarData }

    func updateAvatarData(_ data: Data) { service.updateAvatarData(data) }
    func updateUser(_ user: UserModel) { service.updateUser(user) }
    func updateName(_ name: String) { service.updateName(name) }
    func updateEmail(_ email: String) { service.updateEmail(email) }
    func updatePhone(_ phone: String) { service.updatePhone(phone) }
}
