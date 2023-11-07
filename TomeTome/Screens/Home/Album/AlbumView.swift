//
//  albumView.swift
//  TomeTome
//
//  Created by yeolife on 10/26/23.
//

import SwiftUI

struct AlbumView: View {
    var title: String
    var count: Int
    var imageURL: String?
    
    var body: some View {
        VStack{
            Image(imageURL ?? "")
                .resizable()
                .scaledToFit()
            Text(title)
            Text(String(count))
        }
    }
}

#Preview {
    AlbumView(title: AlbumMockData.sampleTheme1.title,
              count: AlbumMockData.sampleTheme1.messageCount,
              imageURL: AlbumMockData.sampleTheme1.thumbnailURL ?? "")
}
