//
//  SearchButton.swift
//  AuhtTestTask
//
//  Created by Павел Калинин on 04.09.2025.
//

import SwiftUI

struct SearchButton: View {
    var body: some View {
        Button {
            
        } label: {
            HStack {
                Image(systemName: "magnifyingglass")
                
                Text("Search")
                    
            }
            .padding(8)
            .foregroundStyle(.lightGray)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    SearchButton()
}
