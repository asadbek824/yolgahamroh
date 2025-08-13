//
//  ProfileViewModel.swift
//  Profile
//
//  Created by Ilnar Isakov on 13.08.2025.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
    @Published var user: UserModel = .init(
        name: "Asiya",
        email: "a@gmail.com",
        avatarURL: URL(string: "https://images.unsplash.com/photo-1544005313-94ddf0286df2"),
        telephoneNumber: "+998999999999"
    )
    
    var sections: [ProfileSectionModel] {
        [
            ProfileSectionModel(
                header: "Account settings",
                rows: [
                    ProfileRowModel(
                        icon: "person.crop.circle",
                        title: "Edit Profile",
                        destination: .editProfile
                    ),
                    ProfileRowModel(
                        icon: "creditcard",
                        title: "Payment Methods",
                        destination: .paymentMethods
                    ),
                    ProfileRowModel(
                        icon: "bell.badge",
                        title: "Notifiactions",
                        destination: .notifications
                    ),
                    ProfileRowModel(
                        icon: "clock.arrow.circlepath",
                        title: "Ride History",
                        destination: .rideHistory
                    )
                ]
            ),
            ProfileSectionModel(
                header: "Support",
                rows: [
                    ProfileRowModel(
                        icon: "questionmark.circle",
                        title: "Help & Support",
                        destination: .support
                    )
                ]
            ),
            ProfileSectionModel(
                header: nil,
                rows: [
                    ProfileRowModel(
                        icon: "rectangle.portrait.and.arrow.right",
                        title: "Sign Out",
                        tint: .red,
                        destination: .logout,
                        role: .destructive
                    )
                ]
            )
        ]
    }
}
