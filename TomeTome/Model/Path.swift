//
//  Path.swift
//  TomeTome
//
//  Created by yeolife on 10/27/23.
//

import Foundation

enum PathType {
    case TomeTabView
    case CommentView
    case ReplyView
}

final class PathViewModel: ObservableObject {
    @Published var paths: [PathType]
    @Published var isLogin: Bool
    
    init(paths: [PathType] = [],
         isLogin: Bool = false) {
        self.paths = paths
        self.isLogin = isLogin
    }
    
    func pathRemoveAll() {
        paths.removeAll()
    }
}
