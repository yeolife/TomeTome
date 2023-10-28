//
//  AuthenticationModel.swift
//  TomeTome
//
//  Created by yeolife on 10/27/23.
//

import GoogleSignIn

@MainActor
final class AuthenticationViewModel: ObservableObject {
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        
        let tokens = try await helper.signIn()
        
        try await AuthenticationManager.shard.signInWithGoogle(tokens: tokens)
    }
}
