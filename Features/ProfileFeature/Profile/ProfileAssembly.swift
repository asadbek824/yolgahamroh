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
    
    @MainActor
    public func assemble() -> some View {
        let localization = ProfileLocalizationService()
        let sections = ProfileSectionsService(localization: localization)
        let vm = ProfileViewModel(
            localizationService: localization,
            sectionsService: sections
        )
        return ProfileContentView(viewModel: vm)
    }
}
