//
//  PastMessage.swift
//  TomeTome
//
//  Created by yeolife on 10/28/23.
//

import Foundation

struct Reply: Decodable, Identifiable {
    let id: UUID
    let subject: String
    let context: String
    let sendFeature: Bool
    let replyCount: Int
    let date: Date
}

struct PastMessageResponse: Decodable {
    let request: [Comment]
}
