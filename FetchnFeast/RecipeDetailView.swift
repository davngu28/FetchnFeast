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
            RecipeRemoteImage(urlString: recipe.photo_url_large)
                .aspectRatio(contentMode: .fill)
                .frame(width: 320, height: 550)
                .clipped()

            VStack(spacing: 20) {
                // Back button
                HStack {
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
                    .padding(.leading, 10)
                    
                    Spacer()
                }
                .padding(.top, 20)

                Spacer() // Pushes content below the back button
                
                // Recipe Name
                Text(recipe.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(radius: 2)
                
                // Buttons for source and YouTube
                if let sourceURL = recipe.source_url, !sourceURL.isEmpty {
                    Link("Source Recipe", destination: URL(string: sourceURL)!)
                        .buttonStyle(RecipeButtonStyle())
                }

                if let youtubeURLString = recipe.youtube_url, // Ensure the string exists
                   let youtubeURL = URL(string: youtubeURLString), // Ensure it's a valid URL
                   !youtubeURLString.isEmpty { // Ensure it's not empty
                    Link("Watch on YouTube", destination: youtubeURL)
                        .buttonStyle(RecipeButtonStyle())
                }
                
                Spacer() // Pushes everything up
                
            }
            .padding()
        }
        .frame(width: 300, height: 550)
        .background(Color(.systemBackground))
        .shadow(radius: 45)
        
        Spacer()
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
