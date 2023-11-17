//
//  APError.swift
//  TomeTome
//
//  Created by yeolife on 11/4/23.
//

import Foundation

enum SignInWithAppleError: LocalizedError {
    case invalidCredential
    case invalidState
    case unableToFetchToken
    case unableToSerializeToken
    case unableToFindNonce
    
    var description: String? {
        switch self {
        case .invalidCredential:
            return "잘못된 자격 증명: ASAuthorization 실패."
        case .invalidState:
            return "잘못된 상태: 로그인 콜백이 수신 되었지만 로그인 요청이 전송되지 않았습니다."
        case .unableToFetchToken:
            return "ID 토큰을 가져올 수 없습니다."
        case .unableToSerializeToken:
            return "데이터에서 토큰 문자열을 직렬화할 수 없습니다."
        case .unableToFindNonce:
            return "현재 nonce를 찾을 수 없습니다."
        }
    }
}

enum ServerError: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
    case badServerResponse
    
    var description: String? {
        switch self {
        case .invalidURL:
            return "서버에 연결하는 중에 문제가 발생했습니다."
        case .invalidResponse:
            return "서버의 응답이 잘못되었습니다. 나중에 다시 시도해주세요."
        case .invalidData:
            return "서버에서 받은 데이터가 올바르지 않습니다."
        case .unableToComplete:
            return "지금은 요청을 완료할 수 없습니다. 인터넷 연결을 확인하세요."
        case .badServerResponse:
            return "서버에 요청이 올바르지 않습니다"
        }
    }
}

enum userComplete: String {
    case loginSuccess
    case logoutSuccess
    case loginFailure
    
    var description: String? {
        switch self {
        case .loginSuccess:
            return "로그인 되었습니다"
        case .logoutSuccess:
            return "로그아웃 되었습니다"
        case .loginFailure:
            return "로그인 정보가 유효하지 않습니다"
        }
    }
}
