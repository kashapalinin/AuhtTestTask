//
//  AppViewModel.swift
//  AuhtTestTask
//
//  Created by Павел Калинин on 05.09.2025.
//
import Foundation
import FirebaseAuth

class AppViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    init() {
        if let token = KeychainService.shared.get(forKey: "access_token"),
           !token.isEmpty {
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }
    }
    
    func setLoggedIn(_ value: Bool) {
        isLoggedIn = value
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "access_token")
        try? Auth.auth().signOut()
        isLoggedIn = false
    }
}
