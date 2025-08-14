//
//  ProfileLocalizationService.swift
//  Profile
//
//  Created by Ilnar Isakov on 14.08.2025.
//

import DesignSystem

protocol ProfileLocalizationServiceProtocol {
    var navTitle: String { get }
    var accountSet: String { get }
    var editProfile: String { get }
    var paymentMethods: String { get }
    var notifications: String { get }
    var rideHistory: String { get }
    var support: String { get }
    var supAndHelp: String { get }
    var singOut: String { get }
}

final class ProfileLocalizationService: ProfileLocalizationServiceProtocol {
    let locale = DesignSystemProvider.DesignSystemsStrings.self
    
    var navTitle: String { locale.profileTitle }
    var accountSet: String { locale.aboutUs }
    var editProfile: String { locale.editProfile }
    var paymentMethods: String { locale.paymentMethod }
    var notifications: String { locale.notificationTitle }
    var rideHistory: String { locale.myTripsTitle }
    var support: String { locale.helpTitle }
    var supAndHelp: String { locale.helpTitle } // Change
    var singOut: String {locale.logoutButton }
}
