//
//  NewsSectionViewModel.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 31/07/2025.
//

import SwiftUI

class NewsSectionViewModel: ObservableObject {
    var selectedItem: NewsItem? {
        didSet {
            isNewsItemSelected = true
        }
    }
    
    @Published var isNewsItemSelected: Bool = false
}
