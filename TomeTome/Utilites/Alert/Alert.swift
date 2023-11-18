//
//  Alert.swift
//  TomeTome
//
//  Created by yeolife on 10/26/23.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let confirmButton: Alert.Button
    let cancelButton: Alert.Button
}

struct AlertContext {
    static let logoutAlert = AlertItem(title: Text("로그아웃"),
                                       message: Text("로그아웃 하시겠어요?"),
                                       confirmButton: .default(Text("예")),
                                       cancelButton: .default(Text("아니요")))
    
    static let deleteAlert = AlertItem(title: Text("삭제 확인"),
                                       message: Text("삭제된 글은 복구할 수 없어요.\n정말 선택한 글을 삭제 하시겠어요?"),
                                       confirmButton: .default(Text("예")),
                                       cancelButton: .default(Text("아니요")))
}
