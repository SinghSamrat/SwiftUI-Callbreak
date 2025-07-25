//
//  EmtpyScreen.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 13/07/2025.
//

import SwiftUI

struct EmtpyScreen: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack{
            Color("bg_yellow")
            Text("Empty Screen")
        }
        .ignoresSafeArea()
        .overlay(alignment: .topTrailing) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .fontWeight(.black)
                    .frame(width: 30, height: 30)
            }
            .padding(.top)
        }
    }
}
