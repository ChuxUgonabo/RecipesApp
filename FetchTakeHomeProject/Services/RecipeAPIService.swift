//
//  APIService.swift
//  FetchTakeHomeProject
//
//  Created by Chux Ugonabo MacBook on 2025-01-29.
//

import Foundation

class RecipeAPIService {
    
    func fetchRecipe(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        
        let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data Found", code: 0)))
                return
            }
            
            do {

            let decoder = JSONDecoder()
            let recipeAPIList = try decoder.decode([Recipe].self, from: data)

            completion(.success(recipeAPIList))

            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private let baseURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"

    func fetchRecipes() async throws -> RecipeResponse {
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(RecipeResponse.self, from: data)
    }
}
