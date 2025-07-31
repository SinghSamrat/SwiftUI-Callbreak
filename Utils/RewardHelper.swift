//
//  RewardHelper.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 31/07/2025.
//

import SwiftUI

class RewardHelper: ObservableObject {
    static let shared = RewardHelper()

    private init() {}
    
    @Published var gemCount: Int = 100 {
        didSet {
            print("gemCount: ", gemCount)
        }
    }
}
