//
//  EarnGemView.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 27/07/2025.
//

import SwiftUI


struct EarnGemView: View {
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
                    
                    IconImageandTextButtonView() {}
                        .padding(.bottom, 20)
                }
            }
            .border(.red, width: 2)
            .frame(width: 204, height: 240, alignment: .center)
            .padding()
        }
    }
}

#Preview(traits: .landscapeRight) {
    EarnGemView()
}
