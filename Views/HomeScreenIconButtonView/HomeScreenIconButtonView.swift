//
//  HomeScreenIconButtonView.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 25/06/2025.
//

import SwiftUI

enum HomeScreenIconButtonType: String {
    case vsBots = "Play with Bots"
    case vsHumans = "Play with Humans"
    case privateTable = "Private Table"
    case lanMode = "Hotspot"
}

struct HomeScreenIconButtonView: View {
    var type: HomeScreenIconButtonType
    @GestureState var isPressed: Bool = false
    let onTap: () -> Void
    
    var body: some View {
        let press = DragGesture(minimumDistance: 0)
                    .updating($isPressed) { _, state, _ in
                        state = true
                    }
                    .onEnded { _ in
                        print("onTap")
                        onTap()
                    }
        
        ZStack {
            Image(isPressed ? "home_card_pressed" : "home_card_unpressed")
                .resizable()
                .gesture(press)
            
            // Vstack icon, text, text
            
            VStack(spacing: 4) {
                Image(type.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 45)
                
                Text(type.rawValue)
                    .font(.system(size: 14, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("6767 players")
                    .font(.system(size: 8, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color("PlayerCountText"))
                    .padding(.bottom, 9)
            }
        }
        .frame(width: 175, height: 100)
        .gesture(press)
        .offset(y: isPressed ? 2 : 0)
    }
}

#Preview {
    HomeScreenIconButtonView(type: HomeScreenIconButtonType.vsBots, onTap: { })
}
