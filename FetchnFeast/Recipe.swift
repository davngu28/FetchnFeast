//
//  Recipe.swift
//  FetchnFeast
//
//  Created by David Nguyen on 12/3/24.
//

import Foundation

struct Recipe: Decodable, Identifiable {
    let uuid: String
    let name: String
    let cuisine: String
    let photo_url_small: String
    let photo_url_large: String
    let source_url: String?
    let youtube_url: String?
    
    var id: String {
        uuid
    }
}

struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}

struct MockData {
    static let mockRecipe = Recipe(uuid: "abcd", name: "Fried Calamari", cuisine: "Asian", photo_url_small: "", photo_url_large: "", source_url: "", youtube_url: "")

    static let recipes = [mockRecipe, mockRecipe, mockRecipe, mockRecipe, mockRecipe]
}
