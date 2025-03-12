//
//  APIService.swift
//  FetchTakeHomeProject
//
//  Created by Chux Ugonabo MacBook on 2025-01-29.
//

import Foundation

class RecipeAPIService {
    
   
    private let baseURL: String
       
       init(baseURL: String) {
           self.baseURL = baseURL
       }

    func fetchRecipes() async throws -> RecipeResponse {
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            return try JSONDecoder().decode(RecipeResponse.self, from: data)
        } catch let error as URLError {
            print("Network error occurred: \(error.localizedDescription)")
            throw error
        } catch let error as DecodingError {
            print("Decoding error occurred: \(error.localizedDescription)")
            throw error
        } catch {
            print("Unexpected error occurred: \(error.localizedDescription)")
            throw error
        }
    }
}
