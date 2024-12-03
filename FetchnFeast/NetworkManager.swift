//
//  NetworkManager.swift
//  FetchnFeast
//
//  Created by David Nguyen on 12/3/24.
//

import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()

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
    
    func downloadImage(fromURLString: String, completed: @escaping (UIImage?) ->Void ){

            let cacheKey = NSString(string: fromURLString)

            if let image = cache.object(forKey: cacheKey){
                completed(image)
                return
            }

            guard let url = URL(string: fromURLString) else {
                completed(nil)
                return
            }
            
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in

                guard let data = data, let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }
                self.cache.setObject(image, forKey: cacheKey)
                completed(image)
                
            }

            task.resume()
    }
}


