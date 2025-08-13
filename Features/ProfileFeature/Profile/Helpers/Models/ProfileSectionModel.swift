//
//  ProfileSectionModel.swift
//  Profile
//
//  Created by Ilnar Isakov on 13.08.2025.
//

import Foundation

struct ProfileSectionModel: Identifiable {
    let id = UUID()
    let header: String?
    let footer: String? = nil
    let rows: [ProfileRowModel]
}
