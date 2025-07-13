//
//  SwiftUIView.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 05/07/2025.
//

import SwiftUI

struct PlayerInGameHUD: View {
    var score: Int
    
    var body: some View {
        BotInGameHUD(name: "Me", score: score)
    }
}

#Preview {
    PlayerInGameHUD(score: 0)
}
