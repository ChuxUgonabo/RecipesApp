//
//  RecipeViewModel.swift
//  FetchTakeHomeProject
//
//  Created by Chux Ugonabo MacBook on 2025-02-10.
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    private let service = RecipeAPIService()
    
    func fetchRecipes() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            recipes = try await service.fetchRecipes().recipes
        } catch {
            print("Failed to fetch recipes: \(error.localizedDescription)")
        }
    }
}
