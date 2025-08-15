//
//  ProfileAssembly.swift
//  Profile
//
//  Created by Ilnar Isakov on 14.08.2025.
//

import SwiftUI
import CoreServices
import CoreModels
import CoreStorage

public struct ProfileAssembly {
    public init() {}

    @MainActor
    public func assemble() -> some View {
        let userRepo: UserRepositoryProtocol = UserRepository.shared
        let photoPermission: PhotoPermissionChecking = PhotoPermissionService()
        let localization: ProfileLocalizationServiceProtocol = ProfileLocalizationService()
        let sections: ProfileSectionsServiceProtocol = ProfileSectionsService(localization: localization)

        let loadUser = LoadUserUseCase(userRepo: userRepo)
        let updateAvatar = UpdateAvatarUseCase(userRepo: userRepo)

        let coordinator = ProfileCoordinator(localization: localization)

        let vm = ProfileViewModel(
            localization: localization,
            sectionsService: sections,
            photoPermission: photoPermission,
            loadUser: loadUser,
            updateAvatar: updateAvatar,
            router: coordinator
        )

        return ProfileScreen(viewModel: vm, coordinator: coordinator)
    }
}
