//
//  ProfileViewModel.swift
//  Profile
//
//  Created by Ilnar Isakov on 13.08.2025.
//

import SwiftUI
import PhotosUI
import CoreModels
import CoreStorage
import CoreServices

final class ProfileViewModel: ObservableObject {
    @Published var user: UserModel
    @Published var avatarData: Data?
    @Published var showPicker = false
    @Published var pickedItem: PhotosPickerItem?

    private let userService = UserService.shared
    private let sectionsService: ProfileSectionsServiceProtocol
    private let localizationService: ProfileLocalizationServiceProtocol
    
     init(
        localizationService: ProfileLocalizationServiceProtocol,
        sectionsService: ProfileSectionsServiceProtocol
    ) {
        self.localizationService = localizationService
        self.sectionsService = sectionsService
        
        user = userService.currentUser ?? UserModel(
            name: "",
            email: "",
            telephoneNumber: ""
        )
        avatarData = userService.avatarData
    }

    var sections: [ProfileSectionModel] {
        sectionsService.sections(for: user)
    }

    @MainActor
    func handlePickedItem() async {
        guard let pickedItem else { return }
        guard let data = try? await pickedItem.loadTransferable(type: Data.self) else { return }

        avatarData = data
        userService.updateAvatarData(data)
        self.pickedItem = nil
    }

    func onAvatarTap() {
        showPicker = true
    }
    
    func navTitle() -> String {
        localizationService.navTitle
    }
}
