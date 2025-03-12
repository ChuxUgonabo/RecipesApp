//
//  RecipeListView.swift
//  FetchTakeHomeProject
//
//  Created by Chux Ugonabo MacBook on 2025-02-10.
//

import Foundation
import SwiftUI

struct RecipeListView: View {
    @StateObject private var recipeViewModel = RecipeViewModel()
    
    var body: some View {
        NavigationView {
            List(recipeViewModel.recipes, id: \..uuid) { recipe in
                RecipeItemView(recipe: recipe)
            }
            .refreshable {
                await recipeViewModel.fetchRecipes()
            }
            .navigationTitle("Recipes")
            .task {
                await recipeViewModel.fetchRecipes()
            }
        }
    }
}
