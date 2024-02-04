//
//  SearchView-ViewModel.swift
//  AppTeamTechnical
//
//  Created by Vishvak Ravi on 2/4/24.
//

import Foundation

extension SearchView {
    
    @Observable
    class ViewModel {
        var query: String = ""
        var productResults: [ProductModel] = []
        var productTotal: Int?
        
        func getResults() async -> Void {
            do {
                if let searchURL = URL(string: "https://dummyjson.com/products/search?q=\(query)") {
                    let (data, _) = try await URLSession.shared.data(from: searchURL)
                    
                    let searchResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
                    productResults = []
                    for product in searchResponse.products {
                        productResults.append(ProductModel(product: product))
                    }
                    productTotal = searchResponse.total
                }
                
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
