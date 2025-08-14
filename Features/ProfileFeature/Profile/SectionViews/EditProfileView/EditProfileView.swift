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

struct PaymentMethodsView: View {
    var body: some View {
        List {
            Text("**** 1234 · VISA")
            Text("**** 5678 · MasterCard")
        }
    }
}

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

struct TripsListView: View {
    var body: some View {
        List {
            Text("Tashkent → Samarkand · Today 11:00")
            Text("Samarkand → Tashkent · Yesterday 16:00")
        }
    }
}

struct HelpView: View {
    var body: some View {
        List {
            Link("FAQ", destination: URL(string: "https://example.com/faq")!)
            Link("Support chat", destination: URL(string: "https://example.com/support")!)
        }
    }
}
