//
//  SmallIconButtonView.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 24/06/2025.
//

import SwiftUI

struct TinyIconButtonView: View {
    var iconSFName: String = ""
    var xOffset: CGFloat = 0
    var yOffset: CGFloat = 0
    @GestureState var isPressed: Bool = false
    
    let onTap: () -> Void
    
    var body: some View {
        let press = DragGesture(minimumDistance: 0)
            .updating($isPressed) { _, state, _ in
                state = true
            }
        
            .onEnded { _ in
                onTap()
            }
        
        ZStack {
            Image(isPressed ? "small_btn_icon_pressed" : "small_btn_icon_unpressed")
                .resizable()
                .frame(width: 32, height: 32)
            
            // Image icon
            Image(systemName: iconSFName)
                .resizable()
                .foregroundColor(.white)
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .offset(x: xOffset, y: yOffset)
        }
        .gesture(press)
        .offset(y: isPressed ? 2 : 0)
    }
}

#Preview {
    TinyIconButtonView(iconSFName: "bell.fill") {}
}
