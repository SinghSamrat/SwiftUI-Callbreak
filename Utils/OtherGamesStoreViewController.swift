//
//  OtehrGamesStoreViewController.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 12/07/2025.
//

import UIKit
import StoreKit
import SwiftUI

struct AppStoreView: UIViewControllerRepresentable {
    var appID: String = "6443580058"
    
    init() {
        UINavigationBar.setAnimationsEnabled(true)
    }

    func makeUIViewController(context: Context) -> AppStoreWrapperViewController {
        return AppStoreWrapperViewController(appID: appID)
    }

    func updateUIViewController(_ uiViewController: AppStoreWrapperViewController, context: Context) {}
}

class AppStoreWrapperViewController: UIViewController, SKStoreProductViewControllerDelegate {
    let appID: String
    
    init(appID: String) {
        self.appID = appID
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .formSheet
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if self.presentedViewController == nil {
            presentStoreController()
        }
    }

    private func presentStoreController() {
        let storeVC = SKStoreProductViewController()
        storeVC.delegate = self
        let parameters = [SKStoreProductParameterITunesItemIdentifier: appID]
        storeVC.loadProduct(withParameters: parameters, completionBlock: nil)
        self.present(storeVC, animated: true, completion: nil)
    }

    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
