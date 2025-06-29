//
//  AddGemSmallIconButtonView.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 26/06/2025.
//

import SwiftUI

struct AddGemSmallIconButtonView: View {
    var body: some View {
        ZStack {
            Image("small_btn_icon_unpressed")
                .resizable()
                .frame(width: 44, height: 44)
            
            // Image icon
            Image("gem")
                .resizable()
                .foregroundColor(.white)
                .aspectRatio(contentMode: .fit)
                .frame(width: 31.32)
                .rotationEffect(.degrees(4))
                .overlay(alignment: .bottomTrailing) {
                    Text("+4")
                        .foregroundColor(.white)
                        .font(.system(size: 12, design: .rounded))
                        .fontWeight(.bold)
                        .padding(.top)
                }
        }
        .overlay(alignment: .topTrailing) {
            ZStack {
                Rectangle()
                    .fill(Gradient(colors: [Color("AddGemButton"),
                                            Color("AddGemButton2")]))
                    .border(.yellow, width: 1.3)
                    .cornerRadius(2)
                    .frame(width: 17.38, height: 14.22)
                
                Text("AD")
                    .foregroundColor(.white)
                    .font(.system(size: 12, design: .rounded))
                    .fontWeight(.heavy)
                    .shadow(radius: 1, x: 0, y: 0.79)
            }
            .padding([.top, .trailing], -2)
            .rotationEffect(.degrees(8))
        }
    }
}

#Preview {
    AddGemSmallIconButtonView()
}
