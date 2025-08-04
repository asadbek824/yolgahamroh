//
//  Home.swift
//  Home
//
//  Created by Yo'ldoshev Asadbek on 01/08/2025.
//

import SwiftUI
import HomeDesignSystem

public struct HomeView: View {
    
    public init() {  }
    
    public var body: some View {
        VStack {
            Text(HomeDesignSystemStrings.localized("home_title"))
            
            Button {
                
            } label: {
                Text(HomeDesignSystemStrings.localized("search_button"))
            }

        }
        .background(Color.red)
    }
}
