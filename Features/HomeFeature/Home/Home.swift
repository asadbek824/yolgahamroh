//
//  Home.swift
//  Home
//
//  Created by Yo'ldoshev Asadbek on 01/08/2025.
//

import SwiftUI
import DesignSystem
import CoreUIElements
import CoreExtentions

public struct HomeView: View {

    public init() {}

    @State private var searchText: String = ""

    public var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    rideList
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .safeAreaInset(edge: .bottom) {
                bottomBar
                    .padding()
            }
            .navigationTitle(
                DesignSystemProvider.DesignSystemsStrings.homeTitle
            )
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "serach"
            )
            .background(backgroundImage)
            .dismissKeyboardOnTapGesture()
        }
    }
    
    private var backgroundImage: some View {
        GeometryReader { geometry in
            ZStack {
                Image("uzbek_background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.white.opacity(0.9))
                
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.black.opacity(0.5),
                        Color.clear
                    ]),
                    startPoint: .top,
                    endPoint: .center
                )
                
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.clear,
                        Color.black.opacity(0.4)
                    ]),
                    startPoint: .center,
                    endPoint: .bottom
                )
            }
            .ignoresSafeArea()
        }
    }
    
    private var rideList: some View {
        VStack(spacing: 16) {
            ForEach(0..<24, id: \.self) { index in
                RideCardView(
                    from: index % 2 == 0 ? "Москва" : "Тула",
                    to: index % 2 == 0 ? "Тула" : "Москва",
                    time: "Сегодня, \(11 + index % 6):00",
                    price: "130 000 UZS",
                    avatarImage: UIImage(systemName: "person.circle.fill")
                )
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
            }
        }
    }

    private var bottomBar: some View {
        CustomGlassButton(
            title: "Предложить поездку",
            icon: "plus"
        ) {
            print("Button tapped")
        }
    }
}

#Preview {
    HomeView()
}
