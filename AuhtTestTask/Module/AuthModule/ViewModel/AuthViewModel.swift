//
//  AuthViewModel.swift
//  AuhtTestTask
//
//  Created by Павел Калинин on 05.09.2025.
//
import Foundation

class AuthViewModel: ObservableObject {
    private let authService = AuthService.shared
    
    func signInWithGoogle() async throws {
        try await authService.signInWithGoogle()
    }
}
