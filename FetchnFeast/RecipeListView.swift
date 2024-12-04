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
                    Header()
                    
                    SearchBar(searchQuery: $searchQuery)
                        .allowsHitTesting(!isShowingRecipe)
                    
                    if viewModel.isLoading {
                        ProgressView("Fetching recipes...")
                            .padding(.top, 50)
                    } else if filteredRecipes.isEmpty {
                        
                        EmptyStateView().refreshable{
                            viewModel.getRecipes()
                        }
                        
                    } else {
                        RecipeList(
                            recipes: filteredRecipes,
                            isShowingRecipe: $isShowingRecipe,
                            selectedRecipe: $selectedRecipe
                        )
                        .refreshable{
                            viewModel.getRecipes()
                        }
                        .blur(radius: isShowingRecipe ? 20 : 0)
                        .allowsHitTesting(!isShowingRecipe)
                    }
                } .onAppear {
                    viewModel.getRecipes()
                }
                
                if isShowingRecipe, let selectedRecipe = selectedRecipe {
                    RecipeDetailView(recipe: selectedRecipe, isShowingRecipe: $isShowingRecipe)
                        
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

struct EmptyStateView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Sorry, no recipes are available")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.top, 50)
            }
        }
    }
}

struct RecipeList: View {
    let recipes: [Recipe]
    @Binding var isShowingRecipe: Bool
    @Binding var selectedRecipe: Recipe?

    var body: some View {
        List(recipes) { recipe in
            RecipeRow(recipe: recipe)
                .onTapGesture {
                        selectedRecipe = recipe
                        isShowingRecipe = true
                }
                .disabled(isShowingRecipe)
        }
    }
}

struct Header: View {
    var body: some View {
        HStack {
            Text("Fetch N' Feast")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .shadow(radius: 5)
            
            Spacer()
                .frame(width:10)
            
            Image("sampleLogo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
        }
        .padding(.top, 20)
        .padding(.horizontal, 10)
    }
}

#Preview {
    RecipeListView()
}
