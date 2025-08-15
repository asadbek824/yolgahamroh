//
//  UserUseCase.swift
//  Profile
//
//  Created by Yo'ldoshev Asadbek on 15/08/2025.
//

import Foundation
import CoreModels

protocol LoadUserUseCaseProtocol {
    func execute() -> UserModel
}
protocol UpdateAvatarUseCaseProtocol {
    func execute(_ data: Data)
}

protocol UserRepositoryProtocol: AnyObject {
    var currentUser: UserModel? { get }
    var avatarData: Data? { get }
    func updateAvatarData(_ data: Data)
}

struct LoadUserUseCase: LoadUserUseCaseProtocol {
    private let userRepo: UserRepositoryProtocol
    init(userRepo: UserRepositoryProtocol) { self.userRepo = userRepo }

    func execute() -> UserModel {
        userRepo.currentUser ?? UserModel(name: "", email: "", telephoneNumber: "")
    }
}

struct UpdateAvatarUseCase: UpdateAvatarUseCaseProtocol {
    private let userRepo: UserRepositoryProtocol
    init(userRepo: UserRepositoryProtocol) { self.userRepo = userRepo }

    func execute(_ data: Data) {
        userRepo.updateAvatarData(data)
    }
}
