//
//  AuthButton.swift
//  AuhtTestTask
//
//  Created by Павел Калинин on 04.09.2025.
//

import SwiftUI

struct AuthButton: View {
    let image: String
    let text: String
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                Text(text)
                    .foregroundStyle(.black)
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(.horizontal)
    }
}

#Preview {
    AuthButton(image: "applePic", text: "Continue with Apple") {
        
    }
}
