//
//  RecipeListView.swift
//  FetchnFeast
//
//  Created by David Nguyen on 12/3/24.
//

import SwiftUI



struct RecipeListView: View {
    
    @StateObject var viewModel = RecipeListViewModel()
    
    var body: some View {
            ZStack{
                List(viewModel.recipes) { recipe in
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
                        } .padding(.leading)
                    }
                } .onAppear {
                    viewModel.getRecipes()
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

#Preview {
    RecipeListView()
}
