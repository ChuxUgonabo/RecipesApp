//
//  Recipe.swift
//  FetchTakeHomeProject
//
//  Created by Chux Ugonabo MacBook on 2025-01-27.
//

import Foundation

// Root response model
struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable, Hashable {
    
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let uuid: String
    let sourceUrl: String?
    let youtubeUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case uuid
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
    
}
