//
//  Auth.swift
//  TomeTome
//
//  Created by yeolife on 10/27/23.
//

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

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
}
