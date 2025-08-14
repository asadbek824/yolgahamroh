//
//  NotificationsSettingsView.swift
//  Profile
//
//  Created by Ilnar Isakov on 14.08.2025.
//

import SwiftUI

struct NotificationsSettingsView: View {
    @State private var push = true
    @State private var email = false
    @State private var sms = false

    var body: some View {
        Form {
            Toggle("Push", isOn: $push)
            Toggle("Email", isOn: $email)
            Toggle("SMS", isOn: $sms)
        }
    }
}
