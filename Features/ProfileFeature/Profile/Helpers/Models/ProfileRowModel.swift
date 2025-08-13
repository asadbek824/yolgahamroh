//
//  ProfileRowModel.swift
//  Profile
//
//  Created by Ilnar Isakov on 13.08.2025.
//

import SwiftUI

struct ProfileRowModel: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    var subtitle: String? = nil
    var tint: Color? = nil
    var destination: ProfileRoute? = nil
    var role: ButtonRole? = nil
}
