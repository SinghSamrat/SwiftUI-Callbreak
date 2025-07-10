//
//  SidePanelView.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 30/06/2025.
//

import SwiftUI

struct SidePanelView: View {
    let maxWidth: CGFloat = UIScreen.main.bounds.width / 2
    @State private var selectedTabIndex: Int = 0
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            // Top BAR HSTACKS
            TopMenuBarView()
            
            VSeparator()
            
            // Tab Buttons
            HStack(spacing: 0) {
                TabButtonView(buttonType: "Friends", isHighlighted: selectedTabIndex == 0)
                    .frame(width: maxWidth / 2)
                    .onTapGesture {
                        selectedTabIndex = 0
                    }
                
                HSeparator()
                
                TabButtonView(buttonType: "Play Locally", isHighlighted: selectedTabIndex == 1)
                    .frame(width: maxWidth / 2)
                    .onTapGesture {
                        selectedTabIndex = 1
                    }
            }
            .frame(height: 40)
            
            VSeparator()
            
            // Online Friends / Play Locally
            TabView(selection: $selectedTabIndex) {
                FriendsTabView()
                    .tag(0)
                
                PlayLocallyTabView()
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .frame(maxWidth: maxWidth)
        .background(Color("side_panel_bg"))
        .foregroundColor(.white)
    }
}

struct TopMenuBarView: View {
    var body: some View {
        ZStack {
            Color("top_menu")
            
            // buttons 3
            HStack(alignment: .center, spacing: 20) {
                Spacer()
                
                TinyIconButtonView(iconSFName: "person.fill.badge.plus", xOffset: 2, onTap: {})
                TinyIconButtonView(iconSFName: "square.and.pencil", xOffset: 2, yOffset: -2, onTap: {})
                TinyIconButtonView(iconSFName: "bell.fill", onTap: {})
            }
            .padding(.trailing)
        }
        .frame(height: 40)
    }
}

struct TabButtonView: View {
    var buttonType: String
    var isHighlighted: Bool = false
    
    var body: some View {
        ZStack {
            Image(isHighlighted ? "tab_button_bg":"")
                .resizable()
            
            Text(buttonType)
                .foregroundColor(isHighlighted ? .white : .black)
                .font(.system(size: 12))
                .fontWeight(.bold)
        }
    }
}

struct VSeparator: View {
    var body: some View {
        Color.black
            .frame(height: 1)
    }
}

struct HSeparator: View {
    var body: some View {
        Color.black
            .frame(width: 1)
    }
}

struct FriendsTabView: View {
    @GestureState private var isPressed: Bool = false
    var body: some View {
        var pressed = DragGesture(minimumDistance: 0)
            .updating($isPressed) { _, state, _ in
                state = true
            }
        VStack(alignment: .center) {
            HStack(alignment: .bottom){
                Text("Online Friends")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                
                VSeparator()
            }
            .padding()
            
            Spacer()
            
            Text("You must be logged in to use this feature.")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.black)
            
            HStack {
                Image(systemName: "apple.logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 18)
                Text("Sign in with Apple")
            }
            .font(.system(size: 14, weight: .bold))
            .frame(width: 240, height: 49)
            .background(.white)
            .foregroundColor(.black)
            .cornerRadius(10)
            .offset(y: isPressed ? 0 : -2)
            .shadow(color: .black,radius: 2, y: isPressed ? 0 : 2)
            .gesture(pressed)
            
            Spacer()
        }
    }
}

struct PlayLocallyTabView: View {
    var body: some View {
        VStack {
            HStack(alignment: .bottom){
                Text("Lan Game Rooms")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                
                VSeparator()
                
                Text("(0/0)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
            }
            .padding()
            
            Spacer()
            
            ZStack() {
                Rectangle()
                    .foregroundColor(Color("host_lan_game"))
                
                Text("Host Lan Game")
                    .foregroundColor(.white)
            }
            .frame(height: 40)
        }
    }
}



#Preview(traits: .landscapeRight) {
    SidePanelView()
}
