//
//  NewsSectionView.swift
//  SwiftUI-Callbreak
//
//  Created by Samrat Singh on 29/06/2025.
//

import SwiftUI

struct NewsSectionView: View {
//    @State var newsItems: [NewsItem] = MockNewsItems.newsItems
    @StateObject var viewModel: NewsSectionViewModel = NewsSectionViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Image("news_section_bg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Callbreak News")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.top)
                
                HStack(alignment: .bottom, spacing: 22) {
                    if viewModel.isNewsItemSelected {
                        SelectedNewsItemView(selectedItem: viewModel.selectedItem ?? MockNewsItems.sampleNews)
                    } else {
                        NewsLargeItemScrollView()
                        
                        ScrollView {
                            VStack(spacing: 16) {
                                ForEach(MockNewsItems.newsItems) { item in
                                    NewsItemView(newsItem: item) {
                                        
                                        viewModel.selectedItem = item
                                        viewModel.isNewsItemSelected = true
                                    }
                                }
                            }
                        }
                        .frame(height: 300)
                    }
                }
            }
            
            
        }
        .overlay(alignment: .topTrailing) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .fontWeight(.black)
                    .frame(width: 30, height: 30)
            }
            .padding(.top)
        }
        .overlay(alignment: .topLeading) {
            Button(action: {
                viewModel.isNewsItemSelected = false
            }) {
                Image(systemName: "arrowshape.backward.fill")
                    .foregroundColor(.white)
                    .fontWeight(.black)
                    .frame(width: 50, height: 30)
            }
            .padding(.top)
            .opacity(viewModel.isNewsItemSelected ? 1.0 : 0.0)
        }
    }
}

struct NewsItemView: View {
    @GestureState private var isPressed: Bool = false
    var newsItem: NewsItem
    var onTap: () -> Void
    
    var body: some View {
        let press = DragGesture(minimumDistance: 0)
                .updating($isPressed) { _, state, _ in
                    state = true
                }
                .onEnded { _ in
                    onTap()
                }
        
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(width: 410, height: 92)
                .foregroundColor(Color("news_item"))
                .cornerRadius(8)
                .shadow(radius: 1, x: 0, y: isPressed ? 0 : 4)
            
            HStack(alignment: .center, spacing: 16) {
                Image(newsItem.imageName)
                    .resizable()
                    .frame(width: 76, height: 76)
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 1) {
                    Text(newsItem.type)
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                    Text(newsItem.title)
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text(newsItem.date)
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                }
            }
            .padding(.leading)
        }
        .simultaneousGesture(press)
        .offset(y: isPressed ? 2 : 0)
    }
}

struct NewsLargeItemScrollView: View {
    @State private var currentPage = 0
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(0..<4, id: \.self) { index in
                Image("news_large_image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .tag(index)
                    .cornerRadius(8)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(width: 330, height: 300)
        .cornerRadius(8)
        .animation(.easeInOut(duration: 2), value: currentPage)
        .onReceive(timer) { _ in
            currentPage = (currentPage + 1) % 4
        }
    }
}

struct SelectedNewsItemView: View {
    var selectedItem: NewsItem
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundColor(Color("news_item"))
                .frame(height: 300)
                .cornerRadius(8)
            
            ScrollView {
                VStack {
                    Image(selectedItem.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 260)
                        .cornerRadius(8)
                        .padding()
                    
                    Text(selectedItem.title)
                        .font(.system(size: 20, weight: .bold, design: .default))
                }
            }
        }
        .frame(height: 300)
    }
}

#Preview(traits: .landscapeRight) {
    NewsSectionView()
}
