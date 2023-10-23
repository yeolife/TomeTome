//
//  ContentView.swift
//  TomeTome
//
//  Created by yeolife on 10/20/23.
//

import SwiftUI

struct TomeTabView: View {
    var body: some View {
        ZStack {
            TabView {
                SearchView()
                    .tabItem { Label("검색" , systemImage: "magnifyingglass") }
                HomeView()
                    .tabItem { Label("홈" , systemImage: "house.fill") }
                SettingView()
                    .tabItem { Label ("프로필", systemImage: "person.fill") }
            }
            // SeperatorLineView()
        }
    }
}

// MARK: - 구분선
private struct SeperatorLineView: View {
    fileprivate var body: some View {
        VStack {
            Spacer()
            
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]),
                                     startPoint: .top,
                                     endPoint: .bottom)
                )
                .frame(height: 10)
                .padding(.bottom, 60)
        }
    }
}


#Preview {
    TomeTabView()
}
