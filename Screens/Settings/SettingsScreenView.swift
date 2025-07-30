//
//  SettingsScreenView.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 30/07/2025.
//

import SwiftUI

struct SettingsScreenView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Image("settings_background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Settings")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Text("Callbreak v1.24.b1")
                        .font(.footnote)
                        .foregroundColor(Color("button_gray"))
                        .onTapGesture {
                            
                        }
                        .padding(.trailing, 4)
                    
                    Spacer()
                    
                    QuitButtonView {
                        dismiss()
                    }
                }
                .padding(.top)
                .padding(.horizontal, 10)
                .ignoresSafeArea()
                
                // settings items
                HStack(spacing: 10) {
                    VStack(spacing: 10) {
                        LanguageSettingsButtonView(title: "Language (Beta)")
                        SoundSettingsItemView(title: "Sound | Music")
                        SettingsItemView(title: "Auto throw card")
                        SettingsItemView(title: "Highlight valid card")
                        GameSpeedSettingsItem(title: "Game play speed")
                    }
                    
                    VStack(spacing: 10) {
                        ThemeSettingsButtonView(title: "Appearance")
                        SettingsItemView(title: "Show mini scorecards")
                        SettingsItemView(title: "Suggest Bid")
                        SettingsItemView(title: "Push notifications")
                        TimerSettingsItem(title: "Timer")
                    }
                }
                
                HStack {
                    TutorialModeView()
                        .padding(.leading, 10)
                    
                    Spacer()
                    
                    HStack(spacing: 26) {
                        BottomButtonView(title: "Legal Info", icon: "info.circle.fill")
                        BottomButtonView(title: "Game Info", icon: "questionmark")
                        BottomButtonView(title: "Reset to Default", icon: "gearshape.arrow.trianglehead.2.clockwise.rotate.90")
                        BottomButtonView(title: "Rate Us", icon: "star.fill")
                        BottomButtonView(title: "Invite Friend", icon: "person.fill.badge.plus")
                        BottomButtonView(title: "Bug Report", icon: "ladybug.fill")
                    }
                    .padding(.trailing, 10)
                }
                .ignoresSafeArea()
                .padding(.vertical, 5)
            }
        }
    }
}

struct TutorialModeView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color("UserProfileGradient1"), Color("UserProfileGradient2")], startPoint: .top, endPoint: .bottom)
            
            HStack {
                Image(systemName: "text.book.closed.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                
                Text("Tutorial Mode")
                    .font(.system(size: 15, weight: .bold))
            }
        }
        .cornerRadius(8)
        .frame(width: 138, height: 43)
        .shadow(color: .black, radius: 0, x: 0, y: 3)
    }
}

struct BottomButtonView: View {
    var title: String
    var icon: String
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
            
            Text(title)
                .font(.system(size: 10, weight: .medium))
        }
        .foregroundColor(.black)
    }
}

struct TimerSettingsItem: View {
    var title: String
    
    var body: some View {
        ZStack {
            Color("side_panel_bg")
                .cornerRadius(5)
                .shadow(color: .gray, radius: 0, y: 1)
            
            HStack {
                infoIconandTitleHStack(title: title)
                
                Spacer()
                
                SettingsTabButtonsView(tabButtonTitles: ["Analog", "Both", "Digital"])
            }
            .padding(.horizontal)
        }
    }
}

struct GameSpeedSettingsItem: View {
    var title: String
    
    var body: some View {
        ZStack {
            Color("side_panel_bg")
                .cornerRadius(5)
                .shadow(color: .gray, radius: 0, y: 1)
            
            HStack {
                infoIconandTitleHStack(title: title)
                
                Spacer()
                
                SettingsTabButtonsView(tabButtonTitles: ["Slow", "Normal", "Fast"])
            }
            .padding(.horizontal)
        }
    }
}

struct ThemeSettingsButtonView: View {
    var title: String
    
    var body: some View {
        ZStack {
            Color("side_panel_bg")
                .cornerRadius(5)
                .shadow(color: .gray, radius: 0, y: 1)
            
            HStack {
                infoIconandTitleHStack(title: title)
                
                Spacer()
                
                Text("Modern")
                    .foregroundColor(.black)
                    .font(.system(size: 12, weight: .light))
                    .underline()
                
                Text("/")
                    .foregroundColor(.black)
                
                Text("Modern")
                    .foregroundColor(.black)
                    .font(.system(size: 12, weight: .light))
                    .underline()
            }
            .padding(.horizontal)
        }
    }
}

struct LanguageSettingsButtonView: View {
    var title: String
    
    var body: some View {
        ZStack {
            Color("side_panel_bg")
                .cornerRadius(5)
                .shadow(color: .gray, radius: 0, y: 1)
            
            HStack {
                infoIconandTitleHStack(title: title)
                
                Spacer()
                
                Text("English")
                    .foregroundColor(.black)
                    .font(.system(size: 14, weight: .bold))
                    .underline()
            }
            .padding(.horizontal)
        }
    }
}

struct SoundSettingsItemView: View {
    var title: String
    
    @State private var soundOn = true
    @State private var musicOn = true
    
    var body: some View {
        ZStack {
            Color("side_panel_bg")
                .cornerRadius(5)
                .shadow(color: .gray, radius: 0, y: 1)
            
            HStack {
                infoIconandTitleHStack(title: title)
                
                Spacer()
                
                HStack {
                    Image(systemName: soundOn ? "speaker.wave.2.fill" : "speaker.slash.fill")
                        .onTapGesture {
                            soundOn.toggle()
                        }
                        .foregroundColor(.black)
                    
                    HSeparator()
                    
                    Image(systemName: musicOn ? "apple.haptics.and.music.note" : "apple.haptics.and.music.note.slash")
                        .onTapGesture {
                            musicOn.toggle()
                        }
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 40)
    }
}

struct SettingsItemView: View {
    var title: String
    
    @State private var state = true
    
    var body: some View {
        ZStack {
            Color("side_panel_bg")
                .cornerRadius(5)
                .shadow(color: .gray, radius: 0, y: 1)

            Toggle(
                title,
                systemImage: "info.circle",
                isOn: $state
            )
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.black)
            .tint(Color("top_menu"))
            .padding(.horizontal)
        }
        .frame(height: 40)
    }
}

struct infoIconandTitleHStack: View {
    var title: String
    var body: some View {
        HStack {
            Image(systemName: "info.circle")
            
            Text(title)
        }
        .font(.system(size: 14, weight: .bold))
        .foregroundColor(.black)
    }
}

struct SettingsTabButtonsView: View {
    var tabButtonTitles: [String]
    
    @State var tabSelected: Int = 1
    
    var body: some View {
        HStack {
            Text("Slow")
                .padding(.leading)
            HSeparator()
            Text("Normal")
            HSeparator()
            Text("Fast")
                .padding(.trailing)
        }
        .font(.system(size: 10, weight: .bold))
        .foregroundColor(.black)
        .frame(height: 34)
        .cornerRadius(4)
        .border(Color(.black), width: 1)
    }
}

#Preview(traits: .landscapeRight) {
    infoIconandTitleHStack(title: "")
}
