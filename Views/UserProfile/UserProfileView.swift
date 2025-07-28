//
//  UserProfileView.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 25/06/2025.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(colors: [Color("UserProfileGradient2"), Color("UserProfileGradient1")],
                                     startPoint: .bottomLeading,
                                     endPoint: .topTrailing))
                .cornerRadius(32)
                .frame(width: 176, height: 48)
                .shadow(color: Color("shadow"), radius: 0, x: -1, y: 2)
                .overlay(
                        RoundedRectangle(cornerRadius: 32)
                            .stroke(Color("UserProfileBorder"),
                                    lineWidth: 1)
                    )
                
            
            HStack(spacing: 4) {
                Image("avatar_1")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .cornerRadius(.infinity)
                    .overlay(
                            Circle().stroke(Color.white, lineWidth: 2)
                        )
                
                VStack(alignment: .leading, spacing: 5) {
                    // HStack username, flag
                    UsernameAndFlagView()
                    
                    ZStack {
                        Rectangle()
                            .fill(Color("GemsAmountLabel"))
                            .frame(width: 104, height: 20)
                            .cornerRadius(4)
                        
                        Text("100")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 6)
                    
                }
                Spacer()
            }
        }
        .frame(width: 176, height: 48)
        .overlay(UserProfileAddGemButtonView(),
                 alignment: .bottomTrailing)
        
    }
}

struct UsernameAndFlagView: View {
    @StateObject private var nwmonitor = NetworkMonitor()
    
    var body: some View {
        HStack(spacing: 2) {
            Circle()
                .fill(nwmonitor.isWifiAvailable ? .green : .white)
                .frame(width: 6, height: 6)
            
            Text("myusername")
                .foregroundColor(.white)
                .font(.system(size: 10))
                .fontWeight(.medium)
            
            Image("nepal")
                .resizable()
                .frame(width: 13, height: 9)
        }
    }
}

struct UserProfileAddGemButtonView: View {
    var body: some View {
        Image("gem")
            .resizable()
            .rotationEffect(.degrees(4))
            .frame(width: 32, height: 32)
            .padding(.trailing, 8)
            .overlay(
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .green)
                    .shadow(radius: 1, x: 0, y: 1)
                    .padding(.trailing, 8),
                alignment: .bottomTrailing)
    }
}


#Preview {
    UserProfileView()
}
