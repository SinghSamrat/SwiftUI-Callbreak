//
//  BotInGameHUD.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 05/07/2025.
//

import SwiftUI

struct BotInGameHUD: View {
    var body: some View {
        Image("holi_bot")
            .resizable()
            .frame(width: 48, height: 48)
            .cornerRadius(.infinity)
            .overlay(
                Circle().stroke(Color.white, lineWidth: 2)
            )
    }
}

#Preview {
    BotInGameHUD()
}
