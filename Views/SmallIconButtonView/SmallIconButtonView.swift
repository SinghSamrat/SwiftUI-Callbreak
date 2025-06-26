//
//  SmallIconButtonView.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 24/06/2025.
//

import SwiftUI

struct SmallIconButtonView: View {
    var body: some View {
        ZStack {
            Image("small_btn_icon_unpressed")
                .resizable()
                .frame(width: 46.4, height: 48)
            
            // Image icon
            Image(systemName: "gearshape.fill")
                .resizable()
                .foregroundColor(.white)
                .aspectRatio(contentMode: .fit)
                .frame(width: 24)
        }
        
    }
}

#Preview {
    SmallIconButtonView()
}
