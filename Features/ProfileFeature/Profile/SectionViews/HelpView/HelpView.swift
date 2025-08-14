//
//  HelpView.swift
//  Profile
//
//  Created by Ilnar Isakov on 14.08.2025.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        List {
            Link("FAQ", destination: URL(string: "https://example.com/faq")!)
            Link("Support chat", destination: URL(string: "https://example.com/support")!)
        }
    }
}
