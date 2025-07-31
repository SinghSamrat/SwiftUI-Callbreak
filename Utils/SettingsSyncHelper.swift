//
//  SettingsSyncHelper.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 31/07/2025.
//

import SwiftUI

class SettingsSyncHelper {
    let defaults = UserDefaults.standard
    func syncToggleSettings(settingsName: String, isOn: Bool) {
        defaults.set(isOn, forKey: settingsName)
    }
    
    func getToggleSettings(settingsName: String) -> Bool {
        guard let value = defaults.object(forKey: settingsName) else {
            return false
        }
        
        return value as! Bool
    }
}
