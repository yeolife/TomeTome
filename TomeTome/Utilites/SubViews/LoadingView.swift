//
//  LoadingView.swift
//  TomeTome
//
//  Created by yeolife on 10/31/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .accent))
                .scaleEffect(2)
        }
    }
}

#Preview {
    LoadingView()
}
