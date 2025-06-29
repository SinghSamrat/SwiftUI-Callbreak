//
//  OtherGamesButtonView.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 28/06/2025.
//

import SwiftUI

struct OtherGamesButtonView: View {
    @State private var scaleX = 1.0
    
    var body: some View {
        Image("ludo_life_icon")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 46, height: 48)
            .scaleEffect(x: scaleX)
        //            .animation(.linear(duration: 1).repeatForever(), value: scaleX)
            .onAppear {
                rotateContinuously()
            }
    }
        
    func rotateContinuously() {
        Task {
            while true {
                withAnimation(.easeInOut(duration: 0.25)) {
                    scaleX = 0.0
                }
                try? await Task.sleep(nanoseconds: 250_000_000) // Wait for scale down

                withAnimation(.easeInOut(duration: 0.25)) {
                    scaleX = 1.0
                }
                try? await Task.sleep(nanoseconds: 250_000_000) // Wait for scale up

                try? await Task.sleep(nanoseconds: 3_000_000_000) // 2s pause
            }
        }
    }
}



#Preview {
    OtherGamesButtonView()
}
