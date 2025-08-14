//
//  ProfileSectionsService.swift
//  Profile
//
//  Created by Ilnar Isakov on 14.08.2025.
//

import Foundation
import CoreModels

protocol ProfileSectionsServiceProtocol {
    func sections(for user: UserModel) -> [ProfileSectionModel]
}

final class ProfileSectionsService: ProfileSectionsServiceProtocol {
    private let localization: ProfileLocalizationServiceProtocol
    
    init(localization: ProfileLocalizationServiceProtocol) {
        self.localization = localization
    }
    
    func sections(for user: UserModel) -> [ProfileSectionModel] {
        [
            ProfileSectionModel(
                header: localization.accountSet,
                rows: [
                    .init(icon: "person.crop.circle", title: localization.editProfile, destination: .editProfile),
                    .init(icon: "creditcard", title: localization.paymentMethods, destination: .paymentMethods),
                    .init(icon: "bell.badge", title: localization.notifications, destination: .notifications),
                    .init(icon: "clock.arrow.circlepath", title: localization.rideHistory, destination: .rideHistory)
                ]
            ),
            ProfileSectionModel(
                header: localization.support,
                rows: [
                    .init(icon: "questionmark.circle", title: localization.supAndHelp, destination: .support)
                ]
            ),
            ProfileSectionModel(
                header: nil,
                rows: [
                    .init(icon: "rectangle.portrait.and.arrow.right",
                          title: localization.singOut,
                          tint: .red,
                          destination: .logout,
                          role: .destructive)
                ]
            )
        ]
    }
}
