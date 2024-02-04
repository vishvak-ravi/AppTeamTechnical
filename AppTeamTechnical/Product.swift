//
//  Product.swift
//  AppTeamTechnical
//
//  Created by Vishvak Ravi on 2/4/24.
//

import Foundation
import SwiftData

// Define the structure for the products
struct Product: Codable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case price
        case discountPercentage = "discountPercentage"
        case rating
        case stock
        case brand
        case category
        case thumbnail
        case images
    }
    
    static let microsoftSurfaceLaptop4 = Product(
        id: 8,
        title: "Microsoft Surface Laptop 4",
        description: "Style and speed. Stand out on HD video calls backed by Studio Mics. Capture ideas on the vibrant touchscreen.",
        price: 1499,
        discountPercentage: 10.23,
        rating: 4.43,
        stock: 68,
        brand: "Microsoft Surface",
        category: "laptops",
        thumbnail: "https://cdn.dummyjson.com/product-images/8/thumbnail.jpg",
        images: [
            "https://cdn.dummyjson.com/product-images/8/1.jpg",
            "https://cdn.dummyjson.com/product-images/8/2.jpg",
            "https://cdn.dummyjson.com/product-images/8/3.jpg",
            "https://cdn.dummyjson.com/product-images/8/4.jpg",
            "https://cdn.dummyjson.com/product-images/8/thumbnail.jpg"
        ]
    )

    static let samsungGalaxyBook = Product(
        id: 7,
        title: "Samsung Galaxy Book",
        description: "Samsung Galaxy Book S (2020) Laptop With Intel Lakefield Chip, 8GB of RAM Launched",
        price: 1499,
        discountPercentage: 4.15,
        rating: 4.25,
        stock: 50,
        brand: "Samsung",
        category: "laptops",
        thumbnail: "https://cdn.dummyjson.com/product-images/7/thumbnail.jpg",
        images: [
            "https://cdn.dummyjson.com/product-images/7/1.jpg",
            "https://cdn.dummyjson.com/product-images/7/2.jpg",
            "https://cdn.dummyjson.com/product-images/7/3.jpg",
            "https://cdn.dummyjson.com/product-images/7/thumbnail.jpg"
        ]
    )
    static let hpPavilion = Product(
        id: 10,
        title: "HP Pavilion 15-DK1056WM",
        description: "HP Pavilion 15-DK1056WM Gaming Laptop 10th Gen Core i5, 8GB, 256GB SSD, GTX 1650 4GB, Windows 10",
        price: 1099,
        discountPercentage: 6.18,
        rating: 4.43,
        stock: 89,
        brand: "HP Pavilion",
        category: "laptops",
        thumbnail: "https://cdn.dummyjson.com/product-images/10/thumbnail.jpeg",
        images: [
            "https://cdn.dummyjson.com/product-images/10/1.jpg",
            "https://cdn.dummyjson.com/product-images/10/2.jpg",
            "https://cdn.dummyjson.com/product-images/10/3.jpg",
            "https://cdn.dummyjson.com/product-images/10/thumbnail.jpeg"
        ]
    )

}

// Define the structure for the entire response
struct ProductResponse: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int

    enum CodingKeys: String, CodingKey {
        case products
        case total
        case skip
        case limit
    }
}

@Model
class ProductModel {
    let id: Int
    let title: String
    let descript: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
    
    //computed
    let imageURLS: [URL]
    let thumbnailURL: URL?
    let newPrice: Double
    
    //for sorting purposes
    var favorite: Bool
    var quantityInCart: Int

    init(product: Product) {
        self.id = product.id
        self.title = product.title
        self.descript = product.description
        self.price = product.price
        self.discountPercentage = product.discountPercentage
        self.rating = product.rating
        self.stock = product.stock
        self.brand = product.brand
        self.category = product.category
        self.thumbnail = product.thumbnail
        self.images = product.images
        
        var imageURLS: [URL] = []
        for image in product.images {
            if let newURL = URL(string: image) {
                imageURLS.append(newURL)
            }
        }
        self.imageURLS = imageURLS
        
        self.thumbnailURL = URL(string: product.thumbnail)
        
        self.newPrice = product.price * (1 - product.discountPercentage / 100)
        
        self.favorite = false
        self.quantityInCart = 0
    }
}

