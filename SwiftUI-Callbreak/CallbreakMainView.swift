//
//  CallbreakMainView.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 24/06/2025.
//

import SwiftUI

enum HomeScreenNavigationDestination: Identifiable {
    case profile
    case store
    case news
    case settings
    case othergames
    case vsBots
    case vsHumans
    case privateTable
    case lanGame
    
    var id: Int {
        return 1
    }
}

struct CallbreakMainView: View {
    @State var path = NavigationPath()
    @State var showSidePanel: Bool = false
    @State private var showGameplay = false
    @State private var sceneSwitchType: HomeScreenNavigationDestination? = nil
    
    init() {
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                // background
                BackgroundView()
                
                // buttons and ui elements
                VStack {
                    HStack {
                        UserProfileView()
                        
                        Spacer()
                        
                        HStack(spacing: 10) {
                            SmallIconButtonView(iconSFName: "cart.fill", onTap: {sceneSwitchType = .store})
                            SmallIconButtonView(iconSFName: "envelope.fill", onTap: {sceneSwitchType = .news})
//                                .navigationBarBackButtonHidden(true)
                            SmallIconButtonView(iconSFName: "gearshape.fill", onTap: {sceneSwitchType = .settings})
                        }
                    }
                    .padding(.top)
                    
                    Spacer()
                    
                    HStack {
                        SidePanelButtonView(onTap: {
                            withAnimation(.easeInOut) {
                                showSidePanel = true
                            }
                        })
                            .safeAreaPadding(35)
                        
                        Spacer()
                        
                        Grid(horizontalSpacing: 16, verticalSpacing: 16) {
                            GridRow {
                                HomeScreenIconButtonView(type: HomeScreenIconButtonType.vsBots, onTap: {sceneSwitchType = .vsBots})
                                HomeScreenIconButtonView(type: HomeScreenIconButtonType.vsHumans, onTap: {sceneSwitchType = .vsHumans})
                            }
                            
                            GridRow {
                                HomeScreenIconButtonView(type: HomeScreenIconButtonType.privateTable, onTap: {sceneSwitchType = .privateTable})
                                HomeScreenIconButtonView(type: HomeScreenIconButtonType.lanMode, onTap: {sceneSwitchType = .lanGame})
                            }
                        }
                        
                        Spacer()
                        
                        AddGemSmallIconButtonView()
                            .safeAreaPadding(35)
                    }
                    
                    Spacer()
                    
                    HStack {
                        // person.badge
                        SmallIconButtonView(iconSFName: "person.badge.plus.fill", onTap: {sceneSwitchType = .store})
                        
                        Spacer()
                        
                        OtherGamesButtonView()
                    }
                }
                
                // side panel
                if showSidePanel {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                showSidePanel = false
                            }
                        }
                    
                    HStack {
                        SidePanelView()
                        Spacer()
                    }
                    .transition(AnyTransition.move(edge: .leading))
                    .ignoresSafeArea()
                }
                
            }
            .fullScreenCover(item: $sceneSwitchType) { item in
                switch item {
                case .news: NewsSectionView()
                case .profile: AnyView(EmptyView())
                case .store: AnyView(EmptyView())
                case .settings: AnyView(EmptyView())
                case .othergames: AnyView(EmptyView())
                case .vsBots: GameplayView()
                case .vsHumans: AnyView(EmptyView())
                case .privateTable: AnyView(EmptyView())
                case .lanGame: AnyView(EmptyView())
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


//#Preview(traits: .landscapeRight) {
//    CallbreakMainView()
//}
