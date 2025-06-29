//
//  SidePanelButtonViwe.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 28/06/2025.
//

import SwiftUI

struct SidePanelButtonView: View {
    var body: some View {
        ZStack {
            Image("SidePanelButton")
                .resizable()
                .frame(width: 28, height: 64)
            
            Image(systemName: "chevron.right.2")
                .foregroundColor(.white)
                .padding(.leading, 2)
        }
    }
}

#Preview {
    SidePanelButtonView()
}
