//
//  RootView.swift
//  TomeTome
//
//  Created by yeolife on 10/27/23.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationStack {
            AuthenticationView()
        }
    }
}

#Preview {
    RootView()
}
