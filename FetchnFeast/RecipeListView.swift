//
//  RecipeListView.swift
//  FetchnFeast
//
//  Created by David Nguyen on 12/3/24.
//

import SwiftUI



struct RecipeListView: View {
    
    @StateObject var viewModel = RecipeListViewModel()
    @State private var isShowingRecipe = false
    @State private var selectedRecipe: Recipe?
    @State private var searchQuery = ""
    
    private var filteredRecipes: [Recipe] {
        if searchQuery.isEmpty {
            return viewModel.recipes
        } else {
            return viewModel.recipes.filter {
                $0.name.localizedCaseInsensitiveContains(searchQuery) ||
                $0.cuisine.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }
    
    var body: some View {
            ZStack{
                VStack{
                    Text("Fetch N' Feast")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top, 20)
                        .shadow(radius: 5)
                    
                    SearchBar(searchQuery: $searchQuery)
                    
                    List(filteredRecipes) { recipe in
                        RecipeRow(recipe: recipe)
                            .onTapGesture {
                                    selectedRecipe = recipe
                                    isShowingRecipe = true
                            } .disabled(isShowingRecipe)
                    }
                }
                 .onAppear {
                    viewModel.getRecipes()
                }
                
                if isShowingRecipe, let selectedRecipe = selectedRecipe {
                    RecipeDetailView(recipe: selectedRecipe, isShowingRecipe: $isShowingRecipe)
                        
                }
                
                if viewModel.isLoading {
                    ProgressView("Fetching recipes...")
                        .zIndex(1)
                }
            } .alert(item: $viewModel.alertItem) { alert in
                Alert(
                    title: alert.title,
                    message: alert.message,
                    dismissButton: alert.dismissButton
                )
            }
        }
        
    }

struct RecipeRow: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            RecipeRemoteImage(urlString: recipe.photo_url_small)
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            VStack(alignment: .leading, spacing: 5) {
                Text(recipe.name)
                    .font(.title2)
                    .fontWeight(.medium)
                
                Text(recipe.cuisine)
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
            }
            .padding(.leading)
        }
    }
}

struct SearchBar: View {
    @Binding var searchQuery: String

    var body: some View {
        TextField("Search by name or cuisine", text: $searchQuery)
            .padding(10)
            .background(Color.orange)
            .cornerRadius(10)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
    }
}

#Preview {
    RecipeListView()
}
