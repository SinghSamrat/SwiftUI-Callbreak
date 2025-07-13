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
                .frame(width: 74, height: 21)
                .background(Color("score_panel"))
                .cornerRadius(10)
                .opacity(name == "Me" ? 0.0 : 1.0)
            Image(name == "Me" ? "avatar_1" : "holi_bot")
                .resizable()
                .frame(width: 56, height: 56)
                .cornerRadius(.infinity)
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 2)
                )
            Text("\(score)")
                .font(.system(size: 8, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 74, height: name == "Me" ? 15 : 21)
                .background(Color("score_panel"))
                .cornerRadius(10)
        }
    }
}

#Preview {
    BotInGameHUD(name: "Bot 1", score: 1)
}
