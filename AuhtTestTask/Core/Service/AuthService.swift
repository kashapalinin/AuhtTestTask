//
//  AuthService.swift
//  AuhtTestTask
//
//  Created by Павел Калинин on 04.09.2025.
//

import Foundation
import FirebaseAuth
import Firebase
import GoogleSignIn

protocol AuthServiceProtocol {
    func signInWithGoogle() async throws -> String
    func getFirebaseIdToken() async throws -> String
    func loginToBackend(with idToken: String) async throws -> String
}

final class AuthService: AuthServiceProtocol {
    static let shared = AuthService()
    private init() {}
    
    @discardableResult
    func signInWithGoogle() async throws -> String {
        do {
            guard let clientID = FirebaseApp.app()?.options.clientID else {
                throw AuthError.noToken
            }
            
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config
            
            guard let rootVC = await rootViewController() else {
                throw AuthError.rootControllerNotFound
            }
            
            // 🔹 Google SignIn (main thread)
            let result = try await withCheckedThrowingContinuation { continuation in
                Task { @MainActor in
                    do {
                        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootVC)
                        continuation.resume(returning: result)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }
            
            guard let idToken = result.user.idToken?.tokenString else {
                throw AuthError.noToken
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: result.user.accessToken.tokenString
            )
            
            _ = try await Auth.auth().signIn(with: credential)
            
            // Firebase idToken
            let firebaseToken = try await getFirebaseIdToken()
            
            // Backend
            let accessToken = try await loginToBackend(with: firebaseToken)
            
            return accessToken
        } catch let error as URLError {
            if error.code == .notConnectedToInternet {
                throw AuthError.network
            } else {
                throw AuthError.server
            }
        } catch let error as AuthError {
            throw error
        } catch {
            throw AuthError.unknown
        }
    }
    
    func getFirebaseIdToken() async throws -> String {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.noUser
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            user.getIDToken { idToken, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let idToken = idToken {
                    continuation.resume(returning: idToken)
                } else {
                    continuation.resume(throwing: AuthError.noToken)
                }
            }
        }
    }
    
    func loginToBackend(with idToken: String) async throws -> String {
        guard let url = URL(string: "https://api.court360.ai/rpc/client") else {
            throw AuthError.server
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "jsonrpc": "2.0",
            "method": "auth.firebaseLogin",
            "params": ["fbIdToken": idToken],
            "id": 1
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw AuthError.server
        }
        
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        guard let result = json?["result"] as? [String: Any],
              let accessToken = result["accessToken"] as? String else {
            throw AuthError.invalidResponse
        }
        
        KeychainService.shared.save(value: accessToken, forKey: "access_token")
        
        return accessToken
    }
    
    private func rootViewController() async -> UIViewController? {
        await MainActor.run {
            UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .first?.windows.first?.rootViewController
        }
    }
}
