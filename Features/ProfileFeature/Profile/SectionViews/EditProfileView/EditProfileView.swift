//
//  EditProfileView.swift
//  Profile
//
//  Created by Yo'ldoshev Asadbek on 14/08/2025.
//

import SwiftUI

struct EditProfileView: View {
    var body: some View {
        Form {
            Section("Personal") {
                TextField("Name", text: .constant(""))
                TextField("Email", text: .constant(""))
                TextField("Phone", text: .constant(""))
            }
        }
    }
}

