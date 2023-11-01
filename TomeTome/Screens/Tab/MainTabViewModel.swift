//
//  Tab.swift
//  TomeTome
//
//  Created by yeolife on 10/23/23.
//

import Foundation

enum Tab {
    case home
    case search
    case pastMessage
    case setting
}

final class MainTabViewModel: ObservableObject {
    @Published var selectedTab: Tab
    
    init(selectedTab: Tab = .home) {
        self.selectedTab = selectedTab
    }
}
