//
//  GridItemView.swift
//  AuhtTestTask
//
//  Created by Павел Калинин on 04.09.2025.
//
import SwiftUI

struct GridItemView: View {
    var imageName: String
    @State private var isFavorite: Bool = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 160, height: 160)
                .clipped()
                .cornerRadius(12)
            
            Button(action: {
                isFavorite.toggle()
            }) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(isFavorite ? .red : .white)
                    .padding(8)
                    .background(Color.black.opacity(0.4))
                    .clipShape(Circle())
            }
            .padding(8)
        }
    }
}
