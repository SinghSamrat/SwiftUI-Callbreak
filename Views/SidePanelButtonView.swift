//
//  SidePanelButtonViwe.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 28/06/2025.
//

import SwiftUI

struct SidePanelButtonView: View {
    @GestureState var isPressed: Bool = false
    
    var body: some View {
        let press = DragGesture(minimumDistance: 0)
            .updating($isPressed) { _, state, _ in
                state = true
            }
        
        ZStack {
            Image("SidePanelButton")
                .resizable()
                .frame(width: 28, height: 64)
            
            Image(systemName: "chevron.right.2")
                .foregroundColor(.white)
                .padding(.leading, 2)
        }
        .gesture(press)
        .offset(y: isPressed ? 2 : 0)
    }
}

#Preview {
    SidePanelButtonView()
}
