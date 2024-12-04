//
//  RecipeListViewModel.swift
//  FetchnFeast
//
//  Created by David Nguyen on 12/3/24.
//

import SwiftUI

final class RecipeListViewModel: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    
    func getRecipes() {
        isLoading = true
        Task {
            do {
                recipes = try await NetworkManager.shared.getRecipes()
                isLoading = false
            } catch {
                if let ffError = error as? FFError {
                    switch ffError {
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                    }
                }
                alertItem = AlertContext.invalidResponse
                isLoading = false
            }
        }
    }
}
