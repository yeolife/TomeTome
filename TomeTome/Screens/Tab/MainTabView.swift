//
//  TomeTabView.swift
//  TomeTome
//
//  Created by yeolife on 10/28/23.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var pathViewModel: PathViewModel = PathViewModel()
    @StateObject var tabViewModel: TabViewModel = TabViewModel()

    var body: some View {
        NavigationStack(path: $pathViewModel.paths) {
            TabView(selection: $tabViewModel.selectedTab) {
                Group {
                    HomeView()
                        .tabItem { Label("홈", systemImage: "house") }
                        .tag(Tab.home)
                    SearchView()
                        .tabItem { Label("검색", systemImage: "magnifyingglass") }
                        .tag(Tab.search)
                    PastMessageView()
                        .tabItem { Label("From.과거", systemImage: "message") }
                        .tag(Tab.pastMessage)
                        .badge(3)
                    SettingView()
                        .tabItem { Label ("프로필", systemImage: "person") }
                        .tag(Tab.setting)
                }
                /* iOS 16 */
                .toolbarBackground(.white, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.light, for: .tabBar)
            }
            .environmentObject(pathViewModel)
            .environmentObject(tabViewModel)
        }
        .navigationDestination(for: PathType.self) { pathType in
            switch pathType {
            case .CommentView:
                CommentView()
            case .ReplyView:
                ReplyView()
            }
        }
    }
}

#Preview {
    MainTabView(pathViewModel: PathViewModel(), tabViewModel: TabViewModel())
}

