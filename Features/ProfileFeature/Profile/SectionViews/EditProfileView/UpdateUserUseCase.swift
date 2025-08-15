//
//  UpdateUserUseCase.swift
//  Profile
//
//  Created by Yo'ldoshev Asadbek on 15/08/2025.
//

import CoreModels
import CoreServices

protocol UpdateUserUseCaseProtocol {
    func execute(_ user: UserModel)
}

struct UpdateUserUseCase: UpdateUserUseCaseProtocol {
    private let repo: UserRepositoryProtocol
    
    init(repo: UserRepositoryProtocol) { self.repo = repo }
    
    func execute(_ user: UserModel) {
        repo.updateUser(user)
    }
}
