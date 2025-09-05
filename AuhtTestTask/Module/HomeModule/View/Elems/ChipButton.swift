//
//  ChipButton.swift
//  AuhtTestTask
//
//  Created by Павел Калинин on 04.09.2025.
//
import SwiftUI

struct ChipButton: View {
    var title: String
    
    var body: some View {
        Button(action: {
            print("\(title) tapped")
        }) {
            HStack(spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                    .lineLimit(1)
                    .truncationMode(.tail)
                Image(systemName: "chevron.down")
                    .font(.system(size: 12, weight: .semibold))
            }
            .foregroundColor(.black)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.blue.opacity(0.08))
            .clipShape(Capsule())
        }
    }
}
