//
//  ProfileAssembly.swift
//  Profile
//
//  Created by Ilnar Isakov on 14.08.2025.
//

import Foundation
import SwiftUI

public struct ProfileAssembly {
    public init() { }
    
    public func assemble() -> some View {
        let profileLocalizationService = ProfileLocalizationService()
        let profileSectionsService = ProfileSectionsService(localization: profileLocalizationService)
        let viewModel = ProfileViewModel(localizationService: profileLocalizationService, sectionsService: profileSectionsService)
        let profileView = ProfileContentView(viewModel: viewModel)
        return profileView
    }
    
}
