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
        NavigationView() {
            ScrollView {
                VStack {
                    ProfileAvatar()
                    VStack(spacing: 12) {
                        CustomRow(icon: "car", text: "Мои поездки")
                        CustomRow(icon: "creditcard", text: "Способы оплаты")
                        CustomRow(icon: "gearshape", text: "Настройки")
                    }
                    .navigationTitle("Profile")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
        
        
    }
}

struct ProfileAvatar: View {
    var body: some View {
        VStack {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.gray.opacity(0.4), lineWidth: 2)
                )
                .shadow(radius: 4)
                .padding(.top, 20)
            
            VStack(spacing: -10) {
                Text("Name")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, 10)
                
                Text("example@mail")
                    .font(.title2)
                    .fontWeight(.light)
                    .foregroundStyle(.black)
                
            }
            
        }
    }
}

struct CustomRow: View {
    var icon: String
    var text: String
    var showDivider: Bool = true
    
    var body: some View {
        
        HStack {
            Image(systemName: icon)
                .frame(width: 24, height: 24)
                .foregroundColor(.black)
                .scaledToFill()
                .padding(.leading, 10)
            
            Text(text)
                .foregroundColor(.primary)
                .fontWeight(.semibold)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .padding(.leading, -30)
        }
        .contentShape(Rectangle())
        .padding(.vertical, 10)
        
        if showDivider {
            Rectangle()
                .fill(Color.black.opacity(0.2))
                .frame(height: 1)
                .padding(.leading, 10)
                .padding(.trailing, 10)
        }
    }
}


#Preview {
    ProfileContentView()
}
