//
//  AuthenticationView.swift
//  Pets
//
//  Created by Vetha on 10/11/24.
//

import Foundation
import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var authManager: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text(isSignUp ? "Create Account" : "Sign In")
                .font(.largeTitle)
                .bold()
            
            VStack(alignment: .leading, spacing: 5) {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
               // error
                if let emailError = authManager.emailError {
                    Text(emailError)
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            
            VStack(alignment: .leading, spacing: 5) {
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                //  error
                if let passwordError = authManager.passwordError {
                    Text(passwordError)
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            
            Button(action: {
                if isSignUp {
                    authManager.register(email: email, password: password)
                } else {
                    authManager.signIn(email: email, password: password)
                }
            }) {
                Text(isSignUp ? "Sign Up" : "Sign In")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: { isSignUp.toggle() }) {
                Text(isSignUp ? "Already have an account? Sign In" : "New user? Sign Up")
                    .foregroundColor(.blue)
            }
            // " Guest"
                   Button(action: {
                       authManager.continueAsGuest()
                   }) {
                       Text("Continue as Guest")
                           .foregroundColor(.blue)
                         
                   }
               }
               .padding()
           }
       }


