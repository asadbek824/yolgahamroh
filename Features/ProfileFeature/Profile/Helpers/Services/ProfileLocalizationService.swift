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
    var cancelButton: String { get }
    var photoPermissionTitle: String { get }
    var photoPermissionMessage: String { get }
    var openSettingsButton: String { get }
    var logoutTitle: String { get }
    var logoutMessage: String { get }
}

final class ProfileLocalizationService: ProfileLocalizationServiceProtocol {
    private let L = DesignSystemProvider.DesignSystemsStrings.self

    var navTitle: String { L.profileTitle }
    var accountSet: String { L.aboutUs }
    var editProfile: String { L.editProfile }
    var paymentMethods: String { L.paymentMethod }
    var notifications: String { L.notificationTitle }
    var rideHistory: String { L.myTripsTitle }
    var support: String { L.helpTitle }
    var supAndHelp: String { L.helpTitle }
    var singOut: String { L.logoutButton }
    var cancelButton: String { L.cancelButton }
    var photoPermissionTitle: String { L.photoPermissionTitle }
    var photoPermissionMessage: String { L.photoPermissionMessage }
    var openSettingsButton: String { L.openSettingsButton }
    var logoutTitle: String { L.logoutTitle }
    var logoutMessage: String { L.logoutMessage }
}
