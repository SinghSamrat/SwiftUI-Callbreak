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
                .overlay(
                        RoundedRectangle(cornerRadius: 32)
                            .stroke(Color("UserProfileBorder"),
                                    lineWidth: 1)
                    )
            
            HStack(spacing: 4) {
                Image("avatar_1")
                    .resizable()
                    .frame(width: 49, height: 49)
                    .cornerRadius(.infinity)
                
                VStack(alignment: .leading, spacing: 5) {
                    // HStack username, flag
                    HStack(spacing: 2) {
                        Circle()
                            .fill(.green)
                            .frame(width: 6, height: 6)
                        
                        Text("myusername")
                            .foregroundColor(.white)
                            .font(.system(size: 10))
                            .fontWeight(.medium)
                        
                        Image("nepal")
                            .resizable()
                            .frame(width: 13, height: 9)
                    }
                    
                    Rectangle()
                        .fill(Color("GemsAmountLabel"))
                        .frame(width: 104, height: 20)
                        .cornerRadius(4)
                    
                }
                Spacer()
            }
        }
        .frame(width: 176, height: 48)
        .overlay(Image("gem")
            .resizable()
            .frame(width: 32, height: 32),
                 alignment: .bottomTrailing)
    }
}

#Preview {
    UserProfileView()
}
