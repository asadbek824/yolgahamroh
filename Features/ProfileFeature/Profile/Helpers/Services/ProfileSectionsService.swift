//
//  ProfileSectionsService.swift
//  Profile
//
//  Created by Ilnar Isakov on 14.08.2025.
//

import Foundation
import SwiftUI
import CoreModels

protocol ProfileSectionsServiceProtocol {
    func sections(for user: UserModel) -> [ProfileSectionModel]
}

struct ProfileSectionModel: Identifiable {
    let id = UUID()
    let header: String?
    let footer: String? = nil
    let rows: [ProfileRowModel]
}

struct ProfileRowModel: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    var subtitle: String? = nil
    var tint: Color? = nil
    var destination: ProfileRoute? = nil
    var role: ButtonRole? = nil
}

final class ProfileSectionsService: ProfileSectionsServiceProtocol {
    private let L: ProfileLocalizationServiceProtocol

    init(localization: ProfileLocalizationServiceProtocol) { self.L = localization }

    func sections(for user: UserModel) -> [ProfileSectionModel] {
        [
            ProfileSectionModel(
                header: L.accountSet,
                rows: [
                    .init(icon: "person.crop.circle", title: L.editProfile, destination: .editProfile),
                    .init(icon: "creditcard", title: L.paymentMethods, destination: .paymentMethods),
                    .init(icon: "bell.badge", title: L.notifications, destination: .notifications),
                    .init(icon: "clock.arrow.circlepath", title: L.rideHistory, destination: .rideHistory)
                ]
            ),
            ProfileSectionModel(
                header: L.support,
                rows: [.init(icon: "questionmark.circle", title: L.supAndHelp, destination: .support)]
            ),
            ProfileSectionModel(
                header: nil,
                rows: [
                    .init(icon: "rectangle.portrait.and.arrow.right",
                          title: L.singOut,
                          tint: .red,
                          destination: .logout,
                          role: .destructive)
                ]
            )
        ]
    }
}
