//
//  AuthViewModel.swift
//  Pets
//
//  Created by Vetha on 10/11/24.
//

import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    @Published var emailError: String?
    @Published var passwordError: String?
    @Published var validationError: String?
    private var registeredUsers: [String: String] = [:]

    
    
    func validate(email: String, password: String) -> Bool {
        var isValid = true
        emailError = nil
        passwordError = nil
        
        if email.isEmpty || !email.contains("@") {
            emailError = "Please enter a valid email address."
            isValid = false
        }
        
        if password.count < 6 {
            passwordError = "Password must be at least 6 characters long."
            isValid = false
        }
        
        return isValid
    }

    func signIn(email: String, password: String) {
        guard validate(email: email, password: password) else { return }
        
        
        if let registeredPassword = registeredUsers[email] {
            if registeredPassword == password {
               
                self.currentUser = User(id: UUID().uuidString, email: email, isLoggedIn: true)
                self.isAuthenticated = true
            } else {
                passwordError = "Incorrect password."
            }
        } else {
            emailError = "This email is not registered. Please register an account."
        }
    }

  
    
    func register(email: String, password: String) {
        guard validate(email: email, password: password) else { return }
        
        
        if registeredUsers[email] != nil {
            emailError = "This email is already registered. Please use another email or log in."
            return
        }

        
        registeredUsers[email] = password
        self.currentUser = User(id: UUID().uuidString, email: email, isLoggedIn: true)
        self.isAuthenticated = true
    }
    
    func signOut() {
        self.currentUser = nil
        self.isAuthenticated = false
    }
    
    func continueAsGuest() {
        isAuthenticated = true
        currentUser = nil
    }
    // MARK: - Validation Methods
    
    private func validateEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if !emailPredicate.evaluate(with: email) {
            validationError = "Invalid email format"
            return false
        }
        validationError = nil
        return true
    }
    
    private func validatePassword(_ password: String) -> Bool {
        if password.count < 6 {
            validationError = "Password must be at least 6 characters long"
            return false
        }
        validationError = nil
        return true
    }
}
