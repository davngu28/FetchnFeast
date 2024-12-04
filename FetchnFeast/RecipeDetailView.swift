//
//  RecipeDetailView.swift
//  FetchnFeast
//
//  Created by David Nguyen on 12/3/24.
//

import SwiftUI

struct RecipeDetailView: View {
    
    let recipe: Recipe
    @Binding var isShowingRecipe: Bool
    
    var body: some View {
        ZStack {
            backgroundImage
            
            VStack(spacing: 20) {
                HStack{
                    backButton
                    Spacer()
                }.padding(.top,20)
                    .padding(.leading, 10)
                Spacer()
                recipeDetails
                Spacer()
            }
            .padding()
        }
        .frame(width: 300, height: 550)
        .background(Color(.systemBackground))
        .shadow(radius: 45)
    }

    private var backgroundImage: some View {
        RecipeRemoteImage(urlString: recipe.photo_url_large)
            .aspectRatio(contentMode: .fill)
            .frame(width: 320, height: 550)
            .clipped()
    }

    private var backButton: some View {
        Button(action: {
            isShowingRecipe = false
        }) {
            Image(systemName: "chevron.left")
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.6))
                .clipShape(Circle())
        }
    }

    private var recipeDetails: some View {
        VStack(spacing: 10) {
            Text(recipe.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .shadow(radius: 2)

            if let sourceURL = recipe.source_url, !sourceURL.isEmpty {
                Link("Source Recipe", destination: URL(string: sourceURL)!)
                    .buttonStyle(RecipeButtonStyle())
            }

            if let youtubeURLString = recipe.youtube_url,
               let youtubeURL = URL(string: youtubeURLString),
               !youtubeURLString.isEmpty {
                Link("Watch on YouTube", destination: youtubeURL)
                    .buttonStyle(RecipeButtonStyle())
            }
        }
    }
}


struct RecipeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: 260, height: 50)
            .foregroundColor(.white)
            .background(Color.orange)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
    #Preview {
        RecipeDetailView(
            recipe: MockData.mockRecipe,
            isShowingRecipe: .constant(true)
        )
    }
