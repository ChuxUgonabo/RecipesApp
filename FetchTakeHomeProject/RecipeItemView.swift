//
//  ContentView.swift
//  FetchTakeHomeProject
//
//  Created by Chux Ugonabo MacBook on 2025-01-27.
//

import SwiftUI

struct RecipeItemView: View {
    let recipe: Recipe
    @StateObject private var imageLoader = ImageLoader()
    
    var body: some View {
        HStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                ProgressView()
                    .frame(width: 80, height: 80)
            }
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            imageLoader.loadImage(from: recipe.photoUrlSmall)
        }
    }
}
