//
//  ProfileLocalizationService.swift
//  Profile
//
//  Created by Ilnar Isakov on 14.08.2025.
//

import DesignSystem

protocol ProfileLocalizationServiceProtocol {
    var navTitle: String { get }
    var accountSettingsTitle: String { get }
    var editProfile: String { get }
    var paymentMethods: String { get }
    var notifications: String { get }
    var rideHistory: String { get }
    var support: String { get }
    var helpAndSupportTitle: String { get }
    var singOut: String { get }
    var cancelButton: String { get }
    var photoPermissionTitle: String { get }
    var photoPermissionMessage: String { get }
    var openSettingsButton: String { get }
    var logoutTitle: String { get }
    var logoutMessage: String { get }
    var translatedTitle: String { get }
}

final class ProfileLocalizationService: ProfileLocalizationServiceProtocol {
    let locale = DesignSystemProvider.DesignSystemsStrings.self
    
    var navTitle: String { locale.profileTitle }
    var accountSettingsTitle: String { locale.accountSettingsTitle }
    var editProfile: String { locale.editProfile }
    var paymentMethods: String { locale.paymentMethod }
    var notifications: String { locale.notificationTitle }
    var rideHistory: String { locale.myTripsTitle }
    var support: String { locale.helpTitle }
    var helpAndSupportTitle: String { locale.helpAndSupportTitle }
    var singOut: String {locale.logoutButton }
    var cancelButton: String { locale.cancelButton }
    var photoPermissionTitle: String { locale.photoPermissionTitle }
    var photoPermissionMessage: String { locale.photoPermissionMessage }
    var openSettingsButton: String { locale.openSettingsButton }
    var logoutTitle: String { locale.logoutTitle }
    var logoutMessage: String { locale.logoutMessage }
    var translatedTitle: String { locale.translatedTitle }
}
