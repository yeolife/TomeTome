//
//  Path.swift
//  TomeTome
//
//  Created by yeolife on 10/27/23.
//

import Foundation

enum PathType {
    case CommentView
    case ReplyView
}

final class PathViewModel: ObservableObject {
    @Published var paths: [PathType]
    
    init(paths: [PathType] = []) {
        self.paths = paths
    }
}
