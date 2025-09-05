//
//  AppView.swift
//  AuhtTestTask
//
//  Created by Павел Калинин on 05.09.2025.
//

import SwiftUI

struct AppView: View {
    @StateObject var viewModel = AppViewModel()
    
    var body: some View {
        Group {
            if viewModel.isLoggedIn {
                HomeTabView()
                    .environmentObject(viewModel)
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            } else {
                AuthView()
                    .environmentObject(viewModel)
                    .transition(.move(edge: .leading).combined(with: .opacity))
            }
        }
        .animation(.easeInOut, value: viewModel.isLoggedIn)
    }
}

#Preview {
    AppView()
}
