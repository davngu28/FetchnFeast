//
//  NetworkManager.swift
//  FetchnFeast
//
//  Created by David Nguyen on 12/3/24.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()

    private let url = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"

    private init() {}

    func getRecipes(completed: @escaping (Result<[Recipe], FFError>) -> Void){
        guard let url = URL(string: url) else {
            completed(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(RecipeResponse.self, from: data)
                completed(.success(decodedResponse.recipes))
            } catch {
                completed(.failure(.invalidData))
            }
        }

        task.resume()
    }
}
