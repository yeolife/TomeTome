//
//  Toast.swift
//  TomeTome
//
//  Created by yeolife on 10/26/23.
//

import Foundation
import SwiftUI

struct ToastItem {
    let id = UUID()
    let message: Text
}

struct ToastContext {
    // MARK: - Network Toasts
    static let invalidData = ToastItem(message: Text(ServerError.invalidData.description ?? "서버 오류"))
    static let invalidResponse = ToastItem(message: Text(ServerError.invalidResponse.description ?? "서버 오류"))
    static let invalidURL = ToastItem(message: Text(ServerError.invalidURL.description ?? "서버 오류"))
    static let unableToComplete = ToastItem(message: Text(ServerError.unableToComplete.description ?? "서버 오류"))
    static let badServerResponse = ToastItem(message: Text(ServerError.badServerResponse.description ?? "서버 오류"))

    // MARK: - Firebase Toasts
    static let loginSuccess = ToastItem(message: Text(userComplete.loginSuccess.description ?? "로그인 성공"))
    static let logoutSuccess = ToastItem(message: Text(userComplete.logoutSuccess.description ?? "로그아웃 성공"))
    static let loginFailure = ToastItem(message: Text(userComplete.loginFailure.description ?? "로그인 실패"))
}

