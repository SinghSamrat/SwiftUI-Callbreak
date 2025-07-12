//
//  BotInGameHUD.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 05/07/2025.
//

import SwiftUI

struct BotInGameHUD: View {
    var name: String
    var score: Int
    
    var body: some View {
        VStack(spacing: 0) {
            Text(name)
                .font(.system(size: 8, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 48, height: 10)
                .background(Color.gray)
                .cornerRadius(10)
            Image("holi_bot")
                .resizable()
                .frame(width: 48, height: 48)
                .cornerRadius(.infinity)
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 2)
                )
            Text("\(score)")
                .font(.system(size: 8, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 48, height: 10)
                .background(Color.gray)
                .cornerRadius(10)
        }
    }
}

#Preview {
    BotInGameHUD(name: "Bot 1", score: 1)
}
