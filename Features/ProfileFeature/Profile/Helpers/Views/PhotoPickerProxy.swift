//
//  PhotoPickerProxy.swift
//  Profile
//
//  Created by Yo'ldoshev Asadbek on 15/08/2025.
//

import SwiftUI
import PhotosUI

struct PhotoPickerProxy: ViewModifier {
    let onPicked: (PhotosPickerItem?) -> Void
    @Binding var isPresented: Bool
    @State private var item: PhotosPickerItem?

    func body(content: Content) -> some View {
        content
            .background(
                PhotosPicker(
                    selection: $item,
                    matching: .images
                ) {
                    EmptyView()
                }
                .opacity(0.001)
            )
            .onChange(of: isPresented) { newValue in
                if newValue {  }
            }
            .onChange(of: item) { newItem in
                onPicked(newItem)
                isPresented = false
            }
    }
}
