//
//  TomeTabView.swift
//  TomeTome
//
//  Created by yeolife on 10/28/23.
//

import SwiftUI

struct TomeTabView: View {
    @StateObject var tabViewModel: TabViewModel = TabViewModel()
    
    var body: some View {
        TabView(selection: $tabViewModel.selectedTab) {
            HomeView()
                .tabItem { Label("홈", systemImage: "house.fill") }
                .tag(Tab.home)
            SearchView()
                .tabItem { Label("검색", systemImage: "magnifyingglass") }
                .tag(Tab.search)
            PastMessageView()
                .tabItem { Label("From.과거", systemImage: "ellipsis.message.fill") }
                .tag(Tab.pastMessage)
                .badge(3)
            SettingView()
                .tabItem { Label ("프로필", systemImage: "person.fill") }
                .tag(Tab.setting)
        }
    }
}

#Preview {
    TomeTabView()
}
