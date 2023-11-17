//
//  CustomView.swift
//  TomeTome
//
//  Created by yeolife on 11/5/23.
//

import SwiftUI

struct CustomTab<Content: View>: View {
    
    let title: String
    let image: String
    let tag: Tab
    
    let content: Content
    
    var body: some View {
        content
            .tabItem { Label(title, systemImage: image) }
            .tag(tag)
            /* iOS 16 */
            .toolbarBackground(.white, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.light, for: .tabBar)
    }
}
