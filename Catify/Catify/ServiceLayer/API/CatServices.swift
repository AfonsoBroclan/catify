//
//  CatServices.swift
//  Catify
//
//  Created by Afonso Rosa on 01/06/2024.
//

import Foundation

final class CatServices: CatAPI {

    func fetchCats(page: Int, number: Int) async -> CatListResult {

        let urlString = "\(Constants.baseURL)\(Constants.imagesURL)?\(Constants.limitKey)=\(number)&\(Constants.pageKey)=\(page)&\(Constants.apiKey)=\(Constants.apiKeyValue)"

        guard let url = URL(string: urlString) else { return (nil, .invalidURL) }

        do {

            let (data, _) = try await URLSession.shared.data(from: url)

            if let catResults = try? JSONDecoder().decode([CatModel].self, from: data) {

                return (catResults, nil)

            } else {

                return (nil, .invalidJSON)
            }
        } catch  {

            return (nil, .invalidURL)
        }
    }

    private enum Constants {

        static let baseURL = "https://api.thecatapi.com/v1/"
        static let imagesURL = "images/search"
        static let limitKey = "limit"
        static let pageKey = "page"
        static let apiKey = "api_key"
        static let apiKeyValue = "live_fTozWR4dHqLT9GfgAXUqFzY6vLBuyXslbBNArugBl6qTxuUzXK4saEHYfRzXmyTz"
    }
}
