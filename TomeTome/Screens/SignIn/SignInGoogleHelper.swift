//
//  SignGoogleHelper.swift
//  TomeTome
//
//  Created by yeolife on 10/27/23.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

final class SignInGoogleHelper {
    // 2. 구글 로그인을 수행하고 로그인 결과로 얻은 토큰을 반환
    @MainActor
    func signIn() async throws -> GoogleSignInResultModel {
        guard let topVC = TopViewController.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken: String = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        
        let accessToken: String = gidSignInResult.user.accessToken.tokenString
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
    
        return tokens
    }
}
