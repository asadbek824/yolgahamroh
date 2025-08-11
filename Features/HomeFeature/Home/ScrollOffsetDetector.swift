//
//  ScrollOffsetDetector.swift
//  Home
//
//  Created by Yo'ldoshev Asadbek on 04/08/2025.
//

import SwiftUI

struct ScrollOffsetDetector: UIViewRepresentable {
    class Coordinator: NSObject, UIScrollViewDelegate {
        var onScroll: (CGFloat) -> Void

        init(onScroll: @escaping (CGFloat) -> Void) {
            self.onScroll = onScroll
        }

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            onScroll(scrollView.contentOffset.y)
        }
    }

    var onScroll: (CGFloat) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onScroll: onScroll)
    }

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            if let scrollView = view.enclosingScrollView() {
                scrollView.delegate = context.coordinator
            }
        }
         view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

private extension UIView {
    func enclosingScrollView() -> UIScrollView? {
        var view: UIView? = self
        while let current = view {
            if let scrollView = current.superview(of: UIScrollView.self) {
                return scrollView
            }
            view = current.superview
        }
        return nil
    }

    func superview<T: UIView>(of type: T.Type) -> T? {
        var view: UIView? = self
        while let current = view {
            if let typed = current as? T {
                return typed
            }
            view = current.superview
        }
        return nil
    }
}
