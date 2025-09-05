//
//  View+extension.swift
//  AuhtTestTask
//
//  Created by Павел Калинин on 05.09.2025.
//
import SwiftUI

extension View {
    func errorBanner(message: Binding<String?>) -> some View {
        self.modifier(ErrorBannerModifier(message: message))
    }
}
