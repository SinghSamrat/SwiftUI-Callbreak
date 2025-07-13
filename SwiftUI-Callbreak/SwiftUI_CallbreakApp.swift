//
//  SwiftUI_CallbreakApp.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 24/06/2025.
//

import SwiftUI

@main
struct SwiftUI_CallbreakApp: App {
    var body: some Scene {
        WindowGroup {
            CallbreakMainView()
        }
    }
}


class ImmersiveHostingController<Content: View>: UIHostingController<Content> {
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
}

struct ImmersiveView<Content: View>: UIViewControllerRepresentable {
    let content: Content

    func makeUIViewController(context: Context) -> ImmersiveHostingController<Content> {
        let controller = ImmersiveHostingController(rootView: content)
        controller.modalPresentationCapturesStatusBarAppearance = true
        controller.modalPresentationStyle = .fullScreen
        return controller
    }

    func updateUIViewController(_ uiViewController: ImmersiveHostingController<Content>, context: Context) {
        uiViewController.rootView = content
    }
}
