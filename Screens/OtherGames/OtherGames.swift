//
//  OtherGames.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 12/07/2025.
//

import SwiftUI


struct OtherGames: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color("bg_yellow")
                .ignoresSafeArea()
            
            VStack() {
                Text("Try our other games.")
                    .foregroundColor(.black)
                    .font(.system(size: 24, weight: .semibold))
                    .padding(.top)
                
                Spacer(minLength: 30)
                
                HStack {
                    OtherGameItemView()
                }
                
                Spacer()
            }
        }
        .overlay(alignment: .topTrailing) {
            QuitButtonView() {
                dismiss()
            }
            .padding(.top)
            .ignoresSafeArea()
        }
    }
}


struct OtherGameItemView: View {
    @State private var showAppStore = false
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack(spacing: 10) {
            Image("ludo_life_icon")
                .resizable()
                .frame(width: 108, height: 108)
            
            Text("Ludo Life")
                .foregroundColor(.black)
                .font(.system(size: 16, weight: .semibold))
            
            Text("Roll the dice, race to win in Ludo! Play with friends, rivals, or bots. Let the fun begin!")
                .foregroundColor(.black)
                .font(.system(size: 10, weight: .regular))
                .multilineTextAlignment(.center)
                .frame(width: 200)
            
            SimpleTextButtonView(title: "INSTALL") {
                withAnimation {
                    if let url = URL(string: "https://apps.apple.com/np/app/ludo-life/id6443580058") {
                        openURL(url)
                    }
                }
            }
            .padding(.top)
        }
    }
}

#Preview(traits: .landscapeRight) {
    OtherGames()
}
