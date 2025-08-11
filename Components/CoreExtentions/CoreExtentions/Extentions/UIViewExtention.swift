//
//  UIViewExtention.swift
//  CoreExtentions
//
//  Created by Yo'ldoshev Asadbek on 04/08/2025.
//

import SwiftUI

public extension UIView {
    func hideKeyboardOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditingForced))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }

    @objc private func endEditingForced() {
        self.endEditing(true)
    }
}

public extension View {
    func dismissKeyboardOnTapGesture() -> some View {
        self.gesture(
            TapGesture().onEnded {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil, from: nil, for: nil
                )
            }
        )
    }
}
