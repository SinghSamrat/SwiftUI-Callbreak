//
//  SettingsViewModel.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 31/07/2025.
//

import SwiftUI


class SettingsViewModel: ObservableObject {
    private var syncHelper: SettingsSyncHelper = SettingsSyncHelper()
    @Published var isAutoThrow: Bool = false {
        didSet {
            syncHelper.syncToggleSettings(settingsName: "isAutoThrow", isOn: isAutoThrow)
        }
    }
    @Published var isHighlightValidCard: Bool = false {
        didSet {
            syncHelper.syncToggleSettings(settingsName: "isHighlightValidCard", isOn: isHighlightValidCard)
        }
    }
    @Published var isSuggestBid: Bool = false{
        didSet {
            syncHelper.syncToggleSettings(settingsName: "isSuggestBid", isOn: isSuggestBid)
        }
    }
    @Published var isPushNotification: Bool = false {
        didSet {
            syncHelper.syncToggleSettings(settingsName: "isPushNotification", isOn: isPushNotification)
        }
    }
    @Published var isShowMiniScorecard: Bool = false {
        didSet {
            syncHelper.syncToggleSettings(settingsName: "isShowMiniScorecard", isOn: isShowMiniScorecard)
        }
    }
    @Published var isSoundOn: Bool = false {
        didSet {
            syncHelper.syncToggleSettings(settingsName: "isSoundOn", isOn: isSoundOn)
        }
    }
    @Published var isMusicOn: Bool = false {
        didSet {
            syncHelper.syncToggleSettings(settingsName: "isMusicOn", isOn: isMusicOn)
        }
    }
    
    init() {
        self.isAutoThrow = syncHelper.getToggleSettings(settingsName: "isAutoThrow")
        self.isHighlightValidCard = syncHelper.getToggleSettings(settingsName: "isHighlightValidCard")
        self.isSuggestBid = syncHelper.getToggleSettings(settingsName: "isSuggestBid")
        self.isPushNotification = syncHelper.getToggleSettings(settingsName: "isPushNotification")
        self.isShowMiniScorecard = syncHelper.getToggleSettings(settingsName: "isShowMiniScorecard")
        self.isMusicOn = syncHelper.getToggleSettings(settingsName: "isMusicOn")
        self.isSoundOn = syncHelper.getToggleSettings(settingsName: "isSoundOn")
    }
}
