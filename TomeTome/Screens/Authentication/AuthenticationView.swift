//
//  LoginView.swift
//  TomeTome
//
//  Created by yeolife on 10/22/23.
//

import SwiftUI
import GoogleSignInSwift

struct AuthenticationView: View {
    
    @StateObject private var authenticationViewModel = AuthenticationViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            NavigationLink {
                Text("Hello")
            } label: {
                Text("Sign In with Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            }
            
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light,
                                                                      style: .wide,
                                                                      state: .normal)) {
                Task {
                    do {
                        try await authenticationViewModel.signInGoogle()
                    } catch {
                        print(error)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Tome")
    }
}

#Preview {
    NavigationStack {
        AuthenticationView()
    }
}
