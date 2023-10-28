//
//  AuthenticationManager.swift
//  TomeTome
//
//  Created by yeolife on 10/27/23.
//

import Foundation
import FirebaseAuth

struct AuthDataResultMode {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthenticationManager {
    static let shard = AuthenticationManager()
    private init() { }
    
    func getAuthenticatedUser() throws -> AuthDataResultMode {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultMode(user: user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}

// MARK: - Sign in SSO
extension AuthenticationManager {
    
    // 무시할 수도 있음
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultMode {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        
        return try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultMode {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        
        return AuthDataResultMode(user: authDataResult.user)
    }
}
