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
                        //cart.fill
                        SmallIconButtonView()
                        // envelope.fill
                        SmallIconButtonView()
                        // gear.fill
                        SmallIconButtonView()
                    }
                }
                .padding(.top)
                
                Spacer()
                
                HStack {
                    // chevron.right.2
                    SmallIconButtonView()
                        .safeAreaPadding(35)
                    
                    Spacer()
                    
                    VStack {
                        Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                            GridRow {
                                HomeScreenIconButtonView()
                                HomeScreenIconButtonView()
                            }
                            
                            GridRow {
                                HomeScreenIconButtonView()
                                HomeScreenIconButtonView()
                            }
                        }
                    }
                    
                    Spacer()
                    
                    SmallIconButtonView()
                        .safeAreaPadding(35)
                }
                
                Spacer()
                
                HStack {
                    // person.badge
                    SmallIconButtonView()
                    
                    Spacer()
                    
                    SmallIconButtonView()
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
