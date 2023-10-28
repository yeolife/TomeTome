//
//  Home.swift
//  TomeTome
//
//  Created by yeolife on 10/25/23.
//

import Foundation
import SwiftUI

struct Home: Hashable {
    let id: String
    let title: String
    let thumbnailURL: Image?
    let messageCount: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Home, rhs: Home) -> Bool {
        return lhs.id == rhs.id
    }
}

struct HomeMockData {
    static let sampleTheme1: Home = Home(id: "1", title: "취준", thumbnailURL: Image("sample"), messageCount: 3)
    static let sampleTheme2: Home = Home(id: "2", title: "연애", thumbnailURL: Image("sample"), messageCount: 21)
    static let sampleTheme3: Home = Home(id: "3", title: "일상", thumbnailURL: Image("sample"), messageCount: 8)
    
    static let sampleArray = [sampleTheme1, sampleTheme2, sampleTheme3]
}
