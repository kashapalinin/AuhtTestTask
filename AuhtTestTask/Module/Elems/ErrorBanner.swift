//
//  ErrorBanner.swift
//  AuhtTestTask
//
//  Created by Павел Калинин on 05.09.2025.
//
import SwiftUI

struct ErrorBanner: View {
    let message: String
    
    var body: some View {
        Text(message)
            .foregroundColor(.white)
            .font(.system(size: 16, weight: .semibold))
            .multilineTextAlignment(.center)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.red.opacity(0.9))
            .cornerRadius(12)
            .shadow(radius: 10)
            .padding(.horizontal, 16)
    }
}
