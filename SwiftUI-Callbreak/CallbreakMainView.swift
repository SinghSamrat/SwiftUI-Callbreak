//
//  CallbreakMainView.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 24/06/2025.
//

import SwiftUI

struct CallbreakMainView: View {
    var body: some View {
        ZStack {
            // background
            BackgroundView()
            
            // buttons and ui elements
            
            VStack {
                HStack {
                    UserProfileView()
                    
                    Spacer()
                    
                    HStack(spacing: 10) {
                        SmallIconButtonView(iconSFName: "cart.fill")
                        SmallIconButtonView(iconSFName: "envelope.fill")
                        SmallIconButtonView(iconSFName: "gearshape.fill")
                    }
                }
                .padding(.top)
                
                Spacer()
                
                HStack {
                    SidePanelButtonView()
                        .safeAreaPadding(35)
                    
                    Spacer()
                    
                    VStack {
                        Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                            GridRow {
                                HomeScreenIconButtonView(type: HomeScreenIconButtonType.vsBots)
                                HomeScreenIconButtonView(type: HomeScreenIconButtonType.vsHumans)
                            }
                            
                            GridRow {
                                HomeScreenIconButtonView(type: HomeScreenIconButtonType.privateTable)
                                HomeScreenIconButtonView(type: HomeScreenIconButtonType.lanMode)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    AddGemSmallIconButtonView()
                        .safeAreaPadding(35)
                }
                
                Spacer()
                
                HStack {
                    // person.badge
                    SmallIconButtonView(iconSFName: "person.badge.plus.fill")
                    
                    Spacer()
                    
                    OtherGamesButtonView()
                }
            }
        }
    }
}

struct BackgroundView: View {
    var body: some View {
        Image("theme_modern")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
    }
}


#Preview(traits: .landscapeRight) {
    CallbreakMainView()
}
