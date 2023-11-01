//
//  AuthenticationManager.swift
//  TomeTome
//
//  Created by yeolife on 10/27/23.
//

import Foundation
import FirebaseAuth

final class AuthenticationManager {
    static let shared = AuthenticationManager() // 싱글톤
    private init() { } // 외부에서 새로운 인스턴스 생성을 막음
    
    // 현재 인증된 사용자를 반환
    func getAuthenticatedUser() throws -> AuthDataResultMode {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultMode(user: user)
    }
    
    // 현재 인증된 사용자의 로그아웃
    func signOut() throws {
        try Auth.auth().signOut()
    }
}

// MARK: - Sign in SSO
extension AuthenticationManager {
    
    // 3. 로그인 결과로 인증 정보 생성
    @discardableResult // 무시 가능한
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultMode {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        
        return try await signIn(credential: credential)
    }
    
    // 4. 주어진 인증 정보로 로그인
    func signIn(credential: AuthCredential) async throws -> AuthDataResultMode {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        
        return AuthDataResultMode(user: authDataResult.user)
    }
}
