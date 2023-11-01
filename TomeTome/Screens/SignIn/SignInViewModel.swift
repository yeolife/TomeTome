//
//  AuthenticationModel.swift
//  TomeTome
//
//  Created by yeolife on 10/27/23.
//

import GoogleSignIn

@MainActor
final class SignInViewModel: ObservableObject {
    @Published var isLogin: Bool
    @Published var authUser: AuthDataResultMode? {
        didSet {
            self.isLogin = authUser != nil
        }
    }
    
    init(isLogin: Bool = false, authUser: AuthDataResultMode? = nil) {
        self.isLogin = isLogin
        self.authUser = authUser
    }
    
    func getAuthUser() {
        authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
    }
    
    func userLogout() -> Result<Void, Error> {
        do {
            try AuthenticationManager.shared.signOut()
            authUser = nil
            
            return .success(())
        } catch {
            
            return .failure(error)
        }
    }
    
    // 1. 시작
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        
        let tokens = try await helper.signIn()
        
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
}
