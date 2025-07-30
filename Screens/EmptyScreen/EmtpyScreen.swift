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
                .ignoresSafeArea()
            Text("Empty Screen")
        }
        .overlay(alignment: .topTrailing) {
            QuitButtonView {
                dismiss()
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}
