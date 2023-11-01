//
//  LoginView.swift
//  TomeTome
//
//  Created by yeolife on 10/22/23.
//

import SwiftUI
import GoogleSignInSwift

struct SignInView: View {
    @EnvironmentObject private var authenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light,
                                                                      style: .icon,
                                                                      state: .normal)) {
                Task {
                    do {
                        try await authenticationViewModel.signInGoogle()
                        
                        authenticationViewModel.getAuthUser()
                    } catch {
                        print(error)
                    }
                }
            }
        }
        .padding()
    }
}
        
#Preview {
    SignInView()
        .environmentObject(PathViewModel())
}
