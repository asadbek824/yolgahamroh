//
//  ProfileViewModel.swift
//  Profile
//
//  Created by Ilnar Isakov on 13.08.2025.
//

import SwiftUI
import PhotosUI
import CoreModels
import CoreServices

@MainActor
final class ProfileViewModel: ObservableObject {

    struct State: Equatable {
        var user: UserModel
        var avatarData: Data?
        var isLoading: Bool = false

        var showPicker: Bool = false
        var showPermissionAlert: Bool = false
        var showLogoutAlert: Bool = false
    }

    enum Action {
        case onAppear
        case headerAvatarTapped
        case photoPermissionResolved
        case pickedItem(PhotosPickerItem?)
        case tapRow(ProfileRowModel)
        case confirmLogout
        case cancelLogout
        case openSettings
        case setPickerPresented(Bool)
        case setPermissionAlert(Bool)
        case setLogoutAlert(Bool)
    }

    @Published private(set) var state: State

    let localizationService: ProfileLocalizationServiceProtocol
    private let sectionsService: ProfileSectionsServiceProtocol
    private let photoPermission: PhotoPermissionChecking
    private let loadUser: LoadUserUseCaseProtocol
    private let updateAvatar: UpdateAvatarUseCaseProtocol
    private weak var router: ProfileNavigating?

    init(
        localization: ProfileLocalizationServiceProtocol,
        sectionsService: ProfileSectionsServiceProtocol,
        photoPermission: PhotoPermissionChecking,
        loadUser: LoadUserUseCaseProtocol,
        updateAvatar: UpdateAvatarUseCaseProtocol,
        router: ProfileNavigating
    ) {
        self.localizationService = localization
        self.sectionsService = sectionsService
        self.photoPermission = photoPermission
        self.loadUser = loadUser
        self.updateAvatar = updateAvatar
        self.router = router

        let user = loadUser.execute()
        self.state = State(user: user, avatarData: (UserRepository.shared.avatarData))
    }

    var sections: [ProfileSectionModel] { sectionsService.sections(for: state.user) }

    func send(_ action: Action) {
        switch action {
        case .onAppear:
            break

        case .headerAvatarTapped:
            switch photoPermission.status() {
            case .authorized:
                state.showPicker = true
            case .notDetermined:
                Task { @MainActor in
                    let st = await photoPermission.request()
                    state.showPicker = (st == .authorized)
                    state.showPermissionAlert = (st != .authorized)
                }
            case .denied:
                state.showPermissionAlert = true
            @unknown default:
                state.showPermissionAlert = true
            }

        case .photoPermissionResolved:
            break

        case .pickedItem(let item):
            state.showPicker = false
            guard let item else { return }
            Task {
                do {
                    if let data = try await item.loadTransferable(type: Data.self) {
                        self.updateAvatar.execute(data)
                        await MainActor.run {
                            self.state.avatarData = data
                        }
                    }
                } catch {  }
            }

        case .tapRow(let row):
            guard let route = row.destination else { return }
            if route == .logout {
                state.showLogoutAlert = true
            } else {
                router?.navigate(to: route)
            }

        case .confirmLogout:
            state.showLogoutAlert = false

        case .cancelLogout:
            state.showLogoutAlert = false

        case .openSettings:
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        case .setPickerPresented(let presented):
            state.showPicker = presented
            
        case .setPermissionAlert(let shown):
            state.showPermissionAlert = shown
            
        case .setLogoutAlert(let shown):
            state.showLogoutAlert = shown
            
        }
    }
}
