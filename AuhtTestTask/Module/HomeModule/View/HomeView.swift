//
//  HomeView.swift
//  AuhtTestTask
//
//  Created by Павел Калинин on 04.09.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack(alignment: .bottom) {
                            Text("Gifts")
                                .foregroundStyle(.darkBlue)
                                .font(.system(size: 50, weight: .bold))
                            
                            Spacer()
                            
                            SearchButton()
                        }
                        .padding()
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(0..<5) { _ in
                                    Image(.banner)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.bottom)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                LazyHStack(alignment: .top, spacing: 16) {
                                    ForEach(viewModel.categories, id: \.self) { category in
                                        CategoryItem(imageName: category.imageName, title: category.categoryName)
                                    }
                                }
                                
                                Button {
                                    
                                } label: {
                                    Text("Show all")
                                        .font(.system(size: 14, weight: .medium))
                                        .frame(width: 100)
                                }
                            }
                            .foregroundStyle(.darkBlue)
                            .padding(.horizontal)
                        }
                        .padding(.bottom)
                        
                        VStack(spacing: 20) {
                            Button(action: {
                                print("View all categories tapped")
                            }) {
                                Text("View all categories")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                                    )
                            }
                            
                            HStack {
                                ForEach(viewModel.chipCategories, id: \.self) { category in
                                    ChipButton(title: category)
                                }
                            }
                            
                            LazyVStack {
                                LazyVGrid(columns: columns, spacing: 16) {
                                    ForEach(viewModel.products, id: \.self) { product in
                                        GridItemView(imageName: product.productImage)
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal)
                    }
                    .padding(.bottom)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Text("Deliver to 🇺🇸 USD")
                        Image(systemName: "chevron.down")
                    }
                    .foregroundStyle(.darkBlue)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
