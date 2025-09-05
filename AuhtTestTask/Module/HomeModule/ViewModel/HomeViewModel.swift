//
//  HomeViewModel.swift
//  AuhtTestTask
//
//  Created by Павел Калинин on 04.09.2025.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var categories: [Category] = [Category(imageName: "category1", categoryName: "New Popular Arrivals"), Category(imageName: "category2", categoryName: "New Popular Arrivals"), Category(imageName: "category3", categoryName: "Mixed Flowers"), Category(imageName: "category4", categoryName: "Thank you")]
    @Published var chipCategories: [String] = ["Giftboxes", "For Her", "Popular"]
    @Published var products: [Product] = [Product(productImage: "product1"), Product(productImage: "product2"), Product(productImage: "category1"), Product(productImage: "category2")]
}

struct Category: Hashable {
    let imageName: String
    let categoryName: String
}

struct Product: Hashable {
    let productImage: String
}
