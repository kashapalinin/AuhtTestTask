//
//  ErrorBannerModifier.swift
//  AuhtTestTask
//
//  Created by Павел Калинин on 05.09.2025.
//
import SwiftUI

struct ErrorBannerModifier: ViewModifier {
    @Binding var message: String?
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if let message = message {
                VStack {
                    ErrorBanner(message: message)
                        .transition(.asymmetric(
                            insertion: .move(edge: .top).combined(with: .opacity),
                            removal: .move(edge: .top).combined(with: .opacity)
                        ))
                    Spacer()
                }
                .padding(.top, 16)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            self.message = nil
                        }
                    }
                }
            }
        }
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: message)
    }
}
