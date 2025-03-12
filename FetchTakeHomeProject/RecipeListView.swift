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
    @State private var searchText = ""
    @State private var sortOption: SortOption = .name
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                TextField("Search by name or cuisine", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: searchText) { newValue in
                        recipeViewModel.searchRecipes(query: newValue)
                    }
                
                // Sorting Options
                Picker("Sort by", selection: $sortOption) {
                    Text("Name").tag(SortOption.name)
                    Text("Cuisine").tag(SortOption.cuisine)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: sortOption) { newValue in
                    recipeViewModel.sortRecipes(by: newValue)
                }
                
                // Recipe List
                List(recipeViewModel.filteredRecipes, id: \.uuid) { recipe in
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
}

// Sorting Options Enum
enum SortOption {
    case name, cuisine
}
