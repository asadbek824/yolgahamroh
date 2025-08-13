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

    init() {
        user = userService.currentUser ?? UserModel(
            name: "",
            email: "",
            telephoneNumber: ""
        )
        avatarData = userService.avatarData
    }

    var sections: [ProfileSectionModel] {
        [
            ProfileSectionModel(
                header: "Account settings",
                rows: [
                    .init(icon: "person.crop.circle", title: "Edit Profile", destination: .editProfile),
                    .init(icon: "creditcard", title: "Payment Methods", destination: .paymentMethods),
                    .init(icon: "bell.badge", title: "Notifications", destination: .notifications),
                    .init(icon: "clock.arrow.circlepath", title: "Ride History", destination: .rideHistory)
                ]
            ),
            ProfileSectionModel(
                header: "Support",
                rows: [
                    .init(icon: "questionmark.circle", title: "Help & Support", destination: .support)
                ]
            ),
            ProfileSectionModel(
                header: nil,
                rows: [
                    .init(icon: "rectangle.portrait.and.arrow.right",
                          title: "Sign Out",
                          tint: .red,
                          destination: .logout,
                          role: .destructive)
                ]
            )
        ]
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
}
