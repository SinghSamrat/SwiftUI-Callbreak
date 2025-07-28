//
//  EarnGemView.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 27/07/2025.
//

import SwiftUI
import SpriteKit


struct EarnGemView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.8)
                .ignoresSafeArea()
            
            ZStack {
                Color("earn_gem_button_bg")
                    .cornerRadius(5)
                
                VStack(spacing: 20) {
                    ZStack {
                        Image("gem_highlight")
                            .resizable()
                            .frame(width: 204, height: 176)
                        
                        Image("gem")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 106)
                    }
                    
                    IconImageandTextButtonView() {
                        print("IconImageandTextButtonView pressed")
                    }
                        .padding(.bottom, 20)
                }
            }
            .border(.red, width: 2)
            .frame(width: 204, height: 240, alignment: .center)
            .padding()
        }
        .overlay(alignment: .topTrailing) {
            QuitButtonView {
                isShowing = false
            }
            .padding()
        }
        .ignoresSafeArea()
        .background(Color.clear)
    }
}

#Preview(traits: .landscapeRight) {
    EarnGemView(isShowing: .constant(false))
}
