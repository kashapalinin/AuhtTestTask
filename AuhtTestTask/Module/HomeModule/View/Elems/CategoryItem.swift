//
//  CategoryItem.swift
//  AuhtTestTask
//
//  Created by Павел Калинин on 04.09.2025.
//
import SwiftUI

struct CategoryItem: View {
    var imageName: String
    var title: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .multilineTextAlignment(.center)
                .frame(width: 100)
        }
    }
}
