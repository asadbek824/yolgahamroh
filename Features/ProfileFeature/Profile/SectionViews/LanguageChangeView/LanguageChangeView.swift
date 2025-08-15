//
//  LanguageChangeView.swift
//  Profile
//
//  Created by Yo'ldoshev Asadbek on 14/08/2025.
//

import SwiftUI
import DesignSystem

struct LanguageChangeView: View {
    @State private var showSheet = false

    var body: some View {
        VStack {
            Button("Показать Sheet") {
                showSheet.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
        .sheet(isPresented: $showSheet) {
            BottomSheetView()
                .presentationDetents([.fraction(0.50)]) // 25% экрана
                .presentationDragIndicator(.visible)
        }
    }
}

struct BottomSheetView: View {
    var body: some View {
        VStack {
            Text("Bottom Sheet")
                .font(.headline)
            Spacer()
        }
        .padding()
    }
}
