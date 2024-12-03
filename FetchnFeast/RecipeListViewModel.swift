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
        NetworkManager.shared.getRecipes { result in
            DispatchQueue.main.async{
                self.isLoading = false
                
                switch result{
                case .success(let recipes):
                    self.recipes = recipes
                case .failure(let error):
                    switch error {
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
            }
            
        }
    }

}
