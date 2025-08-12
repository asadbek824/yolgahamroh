//
//  ProfileContentView.swift
//  Profile
//
//  Created by Ilnar Isakov on 12.08.2025.
//

import SwiftUI
import CoreUIElements

public struct ProfileContentView: View {
    
    public init() {}
    
    public var body: some View {
        
        NavigationView {
            List {
                Text("Edit Profile")
            }
        }
        .navigationTitle("Profile")
        
    }
}

#Preview {
    ProfileContentView()
}
