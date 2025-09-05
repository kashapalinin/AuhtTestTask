//
//  ContentView.swift
//  AuhtTestTask
//
//  Created by Павел Калинин on 04.09.2025.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @StateObject var viewModel = AuthViewModel()
    @State private var errorMessage: String?
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                VStack {
                    VStack(spacing: 16) {
                        Text("Welcome")
                            .foregroundStyle(.darkBlue)
                            .font(.custom("GleeFinder-KqwZ", size: 50))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Enter your phone number. We will send you an SMS with a confirmation code to this number.")
                            .font(.system(size: 14))
                            .foregroundStyle(.lightGray)
                    }
                    .padding(.horizontal)
                    
                    ZStack {
                        Image(.figureBack)
                        
                        VStack(spacing: 10) {
                            Image(.flowerPic)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 285)
                            
                            VStack {
                                AuthButton(image: "applePic", text: "Continue with Apple") {
                                    
                                }
                                
                                AuthButton(image: "googlePic", text: "Continue with Google") {
                                    Task {
                                        isLoading = true
                                        do {
                                            try await viewModel.signInWithGoogle()
                                            appViewModel.setLoggedIn(true)
                                        } catch {
                                            errorMessage = error.localizedDescription
                                        }
                                        isLoading = false
                                    }
                                }
                                .disabled(isLoading)
                            }
                            
                            Text("By continuing, you agree to Assetsy’s Terms of Use and Privacy Policy")
                                .foregroundStyle(.black)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 11))
                        }
                        .padding(.top, 30)
                    }
                    Spacer()
                }
                
                if isLoading {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        appViewModel.setLoggedIn(true)
                    } label: {
                        Text("Skip")
                            .tint(.darkBlue)
                    }
                }
            }
        }
        .errorBanner(message: $errorMessage)
    }
}

#Preview {
    AuthView()
}
