//
//  CallbreakMainView.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 24/06/2025.
//

import SwiftUI

enum HomeScreenNavigationDestination {
    case profile
    case store
    case news
    case settings
    case othergames
    case vsBots
    case vsHumans
    case privateTable
    case lanGame
}

struct CallbreakMainView: View {
    @State var path = NavigationPath()
    @State var showSidePanel: Bool = false
    
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
                            SmallIconButtonView(iconSFName: "cart.fill", onTap: {path.append(HomeScreenNavigationDestination.store)})
                            SmallIconButtonView(iconSFName: "envelope.fill", onTap: {path.append(HomeScreenNavigationDestination.news)})
//                                .navigationBarBackButtonHidden(true)
                            SmallIconButtonView(iconSFName: "gearshape.fill", onTap: {path.append(HomeScreenNavigationDestination.settings)})
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
                                HomeScreenIconButtonView(type: HomeScreenIconButtonType.vsBots, onTap: {path.append(HomeScreenNavigationDestination.vsBots)})
                                HomeScreenIconButtonView(type: HomeScreenIconButtonType.vsHumans, onTap: {path.append(HomeScreenNavigationDestination.vsHumans)})
                            }
                            
                            GridRow {
                                HomeScreenIconButtonView(type: HomeScreenIconButtonType.privateTable, onTap: {path.append(HomeScreenNavigationDestination.privateTable)})
                                HomeScreenIconButtonView(type: HomeScreenIconButtonType.lanMode, onTap: {path.append(HomeScreenNavigationDestination.lanGame)})
                            }
                        }
                        
                        Spacer()
                        
                        AddGemSmallIconButtonView()
                            .safeAreaPadding(35)
                    }
                    
                    Spacer()
                    
                    HStack {
                        // person.badge
                        SmallIconButtonView(iconSFName: "person.badge.plus.fill", onTap: {
                            withAnimation(nil) {
                                path.append(HomeScreenNavigationDestination.store)
                            }
                        })
                        
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
            .navigationDestination(for: HomeScreenNavigationDestination.self) { type in
                switch type {
                case .vsBots: GameplayView()
                case .vsHumans: AnyView(EmptyView())
                case .privateTable: AnyView(EmptyView())
                case .lanGame: AnyView(EmptyView())
                case .profile: AnyView(EmptyView())
                case .store: AnyView(EmptyView())
                case .news: NewsSectionView()
                case .settings: AnyView(EmptyView())
                case .othergames: AnyView(EmptyView())
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
