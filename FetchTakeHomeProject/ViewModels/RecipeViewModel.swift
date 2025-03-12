//
//  RecipeViewModel.swift
//  FetchTakeHomeProject
//
//  Created by Chux Ugonabo MacBook on 2025-02-10.
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var filteredRecipes: [Recipe] = []
    @Published var isLoading = false
    @Published var error: Error?
    private let service = RecipeAPIService(baseURL: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
    
    @MainActor func fetchRecipes() async {
        isLoading = true
        error = nil // Reset error state
        
        do {
            recipes = try await service.fetchRecipes().recipes
            filteredRecipes = recipes // Initialize filteredRecipes
        } catch {
            self.error = error
            print("Failed to fetch recipes: \(error.localizedDescription)")
        }
        isLoading = false
    }
    
    func searchRecipes(query: String) {
        if query.isEmpty {
            filteredRecipes = recipes
        } else {
            filteredRecipes = recipes.filter { recipe in
                recipe.name.localizedCaseInsensitiveContains(query) ||
                recipe.cuisine.localizedCaseInsensitiveContains(query)
            }
        }
    }
    
    func sortRecipes(by option: SortOption) {
        switch option {
        case .name:
            filteredRecipes.sort { $0.name < $1.name }
        case .cuisine:
            filteredRecipes.sort { $0.cuisine < $1.cuisine }
        }
    }
}
