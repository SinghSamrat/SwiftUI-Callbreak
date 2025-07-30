//
//  News.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 29/06/2025.
//

import Foundation

enum NewsType: String {
    case news = "News"
    case event = "Event"
}


struct NewsItem: Identifiable {
    let id: Int
    let type: NewsType.RawValue
    let title: String
    let date: String
    let imageName: String
}

struct MockNewsItems {
    static let sampleNews = NewsItem(id: 1, type: NewsType.event.rawValue, title: "Anniversary Card Sets", date: "4th Nov", imageName: "anniversary")
    
    static let newsItems: [NewsItem] = [
        NewsItem(id: 1, type: NewsType.event.rawValue, title: "Anniversary Card Sets", date: "4th Nov", imageName: "anniversary"),
        NewsItem(id: 2, type: NewsType.event.rawValue, title: "New Avatars", date: "5th Nov", imageName: "newavatars"),
        NewsItem(id: 3, type: NewsType.news.rawValue, title: "Christmas Cheer is Here!", date: "5th Nov", imageName: "christmas1"),
        NewsItem(id: 4, type: NewsType.news.rawValue, title: "Get Ready for VC!", date: "5th Nov", imageName: "christmas2"),
        NewsItem(id: 5, type: NewsType.event.rawValue, title: "New Avatars", date: "5th Nov", imageName: "newavatars")]
}
