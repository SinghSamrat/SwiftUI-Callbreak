//
//  SimpleTextButtonView.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 12/07/2025.
//

import SwiftUI

struct SimpleTextButtonView: View {
    var title: String = "Title"
    @GestureState var isPressed: Bool = false
    
    var onTap: () -> Void
    
    var body: some View {
        let press = DragGesture(minimumDistance: 0)
            .updating($isPressed) { _, state, _ in
                state = true
            }
            .onEnded { _ in
                onTap()
            }
        
        ZStack {
            Rectangle()
                .fill(LinearGradient(colors: [Color("button_green_1"), Color("button_green_2")],
                                                startPoint: .top,
                                                endPoint: .bottom))
                .frame(width: 80, height: 36)
                .cornerRadius(8)
                .shadow(color: .black, radius: 2, x: 0, y: isPressed ? 0 : 2)
            
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 12, weight: .bold))
        }
        .gesture(press)
        .offset(y: isPressed ? 2 : 0)
    }
}

#Preview {
    SimpleTextButtonView(onTap: {})
}
