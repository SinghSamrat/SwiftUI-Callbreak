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
            Image("theme_modern")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .ignoresSafeArea()
            Text("Nothing to see here!")
                .font(.system(size: 24))
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing) {
            QuitButtonView {
                dismiss()
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}
