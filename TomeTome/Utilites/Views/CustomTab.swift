//
//  CustomView.swift
//  TomeTome
//
//  Created by yeolife on 11/5/23.
//

import SwiftUI

struct CustomTab<Content: View>: View {
    
    let content: Content
    
    var body: some View {
        content
            /* iOS 16 */
            .toolbarBackground(.white, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.light, for: .tabBar)
    }
}
