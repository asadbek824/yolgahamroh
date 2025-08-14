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

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var user: UserModel
    @Published var avatarData: Data?
    @Published var showPicker = false
    @Published var pickedItem: PhotosPickerItem?

    @Published var showPermissionAlert = false

    private let userService = UserService.shared
    private let sectionsService: ProfileSectionsServiceProtocol
    private let localizationService: ProfileLocalizationServiceProtocol
    private let photoPermission: PhotoPermissionChecking

    init(
        localizationService: ProfileLocalizationServiceProtocol,
        sectionsService: ProfileSectionsServiceProtocol,
        photoPermission: PhotoPermissionChecking = PhotoPermissionService()
    ) {
        self.localizationService = localizationService
        self.sectionsService = sectionsService
        self.photoPermission = photoPermission

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

    func navTitle() -> String {
        localizationService.navTitle
    }

    func onAvatarTap() {
        switch photoPermission.status() {
        case .authorized:
            showPicker = true
        case .notDetermined:
            Task {
                let st = await photoPermission.request()
                if st == .authorized {
                    showPicker = true
                } else {
                    showPermissionAlert = true
                }
            }
        case .denied:
            showPermissionAlert = true
        @unknown default:
            showPermissionAlert = true
        }
    }

    func handlePickedItem() async {
        guard let pickedItem else { return }
        do {
            if let data = try await pickedItem.loadTransferable(type: Data.self) {
                avatarData = data
                userService.updateAvatarData(data)
            }
        } catch {  }
        self.pickedItem = nil
    }

    func openSystemSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
