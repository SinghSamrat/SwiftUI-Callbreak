//
//  NetworkMonitor.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 28/07/2025.
//

import Foundation
import Network

let monitor = NWPathMonitor()

class NetworkMonitor: ObservableObject {
    @Published var isWifiAvailable: Bool = false
    
    func addNetworkMonitor() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self?.isWifiAvailable = true
                } else {
                    self?.isWifiAvailable = false
                }
            }
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    init() {
        print("addNetworkMonitor")
        addNetworkMonitor()
    }
}
