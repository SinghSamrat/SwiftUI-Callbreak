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
    @State private var isRewardedAdShowing: Bool = false
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
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
                                .frame(width: 204, height: 172)
                            
                            Image("gem")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 106)
                        }
                        
                        IconImageandTextButtonView(title: "Get 4", iconLeft: "play.rectangle.fill", imageRight: "gem") {
                            print("IconImageandTextButtonView pressed")
                            isRewardedAdShowing = true
                        }
                            .padding(.bottom, 20)
                    }
                }
                .frame(width: 204, height: 240, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.red, lineWidth: 2)
                )
                .padding()
                
                if isAnimating {
                    GemAnimationView() {
                        isShowing = false
                    }
                }
            }
            .overlay(alignment: .topTrailing) {
                QuitButtonView {
                    isShowing = false
                }
                .padding()
            }
            .overlay(alignment: .topLeading) {
                UserProfileView() {
                    
                } onEarnGemsTap: {
                    
                }
                .padding()
            }
            .ignoresSafeArea()
            .background(Color.clear)
        }
        if isRewardedAdShowing {
            RewardedAdView {
                isRewardedAdShowing = false
                isAnimating = true
            }
        }
    }
}

struct LoadingBarView: View {
    @State var progress: CGFloat = 0.0

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Color.gray.opacity(0.3) // background track

                Color.blue
                    .frame(width: geo.size.width * progress)
            }
            .frame(height: 5)
            .cornerRadius(2.5)
        }
        .frame(height: 5)
        .onAppear() {
            withAnimation(.linear(duration: 5.0)) {
                progress = 1.0
            }
        }
    }
    
}

struct RewardedAdView: View {
    var rewardedAdDismissed: () -> Void
    var body: some View {
        ZStack{
            Rectangle()
                .background(Color.white)
                .frame(width: .infinity, height: .infinity)
            
            Image("arun")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                LoadingBarView()
                    .padding(.bottom, 40)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing) {
            HStack {
                Text("Reward Granted")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.white)
                    .frame(width: 100, height: 30)
                    .background(Color.gray)
                    .cornerRadius(5)

                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.gray)
                    .padding()
                    .onTapGesture {
                        rewardedAdDismissed()
                    }
            }
            
        }
        
        .ignoresSafeArea()
    }
}

struct GemAnimationView: View {
    @State private var animateFlags = [false, false, false, false]
    var animationFinished: () -> Void

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black.opacity(0.8).ignoresSafeArea()
                
                ForEach(0..<4) { index in
                    Image("gem")
                        .resizable()
//                        .fill(Color.green)
                        .frame(width: 30 + Double(index) * 2, height: 30 + Double(index) * 2)
                        .scaleEffect(animateFlags[index] ? 0.0 : 1.0)
                        .position(
                            x: animateFlags[index] ? CGFloat(20) : (geo.size.width / 2) + (Double.random(in: -30.0...50.0)),
                            y: animateFlags[index] ? CGFloat(20) : (geo.size.height / 2) + (Double.random(in: -30.0...50.0))
                        )
                        .animation(
                            .easeOut(duration: 1.0).delay(Double.random(in: 1.5...1.6)),
                            value: animateFlags[index]
                        )
                        .opacity(animateFlags[index] ? 1.0 : 0.0)
                }
            }
            .onAppear() {
                for i in 0..<4 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * Double.random(in: 0.15...0.25)) {
                        animateFlags[i] = true
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    animationFinished()
                }
            }
        }
    }
}



#Preview(traits: .landscapeRight) {
//    EarnGemView(isShowing: .constant(false))
    RewardedAdView() {}
}
