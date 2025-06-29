//
//  SmallIconButtonView.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 24/06/2025.
//

import SwiftUI

struct SmallIconButtonView: View {
    var iconSFName: String = ""
    
    @GestureState var isPressed: Bool = false
    
    var body: some View {
        let press = DragGesture(minimumDistance: 0)
            .updating($isPressed) { _, state, _ in
                state = true
            }
        
        ZStack {
            Image(isPressed ? "small_btn_icon_pressed" : "small_btn_icon_unpressed")
                .resizable()
                .frame(width: 44, height: 44)
            
            // Image icon
            Image(systemName: iconSFName)
                .resizable()
                .foregroundColor(.white)
                .aspectRatio(contentMode: .fit)
                .frame(width: 24)
        }
        .gesture(press)
        .offset(y: isPressed ? 2 : 0)
    }
}

#Preview {
    SmallIconButtonView(iconSFName: "gearshape.fill")
}
