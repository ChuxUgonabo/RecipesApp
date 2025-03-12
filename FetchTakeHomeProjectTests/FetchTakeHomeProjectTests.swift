//
//  FetchTakeHomeProjectTests.swift
//  FetchTakeHomeProjectTests
//
//  Created by Chux Ugonabo MacBook on 2025-01-27.
//

import XCTest
@testable import FetchTakeHomeProject

final class FetchTakeHomeProjectTests: XCTestCase {


    func testFetchRecipesSuccess() async throws {
        let apiService = RecipeAPIService(baseURL: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
        do {
            let response = try await apiService.fetchRecipes()
            XCTAssertFalse(response.recipes.isEmpty, "Recipes should not be empty")
        } catch {
            XCTFail("Expected successful fetch, but got error: \(error)")
        }
    }

    func testFetchRecipesMalformedData() async throws {
        // Simulate malformed data scenario
        let malformedDataURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"

        let apiService = RecipeAPIService(baseURL: malformedDataURL)
        do {
            _ = try await apiService.fetchRecipes()
            XCTFail("Expected failure due to malformed data, but succeeded")
        } catch {
            XCTAssertTrue(error is DecodingError, "Expected DecodingError, but got: \(error)")
        }
    }

    func testFetchRecipesEmptyData() async throws {
        let emptyDataURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
        let apiService = RecipeAPIService(baseURL: emptyDataURL)
        do {
            let response = try await apiService.fetchRecipes()
            XCTAssertTrue(response.recipes.isEmpty, "Recipes should be empty")
        } catch {
            XCTFail("Expected successful fetch with empty data, but got error: \(error)")
        }
    }

    func testFetchRecipesNetworkError() async throws {
        let invalidURL = "https://invalid.url/"
        let apiService = RecipeAPIService(baseURL: invalidURL)
        do {
            _ = try await apiService.fetchRecipes()
            XCTFail("Expected network error, but succeeded")
        } catch let error as URLError {
            XCTAssertEqual(error.code, .cannotFindHost, "Expected bad URL error, but got: \(error)")
        } catch {
            XCTFail("Expected URLError, but got: \(error)")
        }
    }

    func testImageCaching() {
        let cacheManager = ImageCacheManager.shared
        let testImage = UIImage(systemName: "star")!
        let testURL = "https://example.com/test.jpg"
        
        // Cache the image
        cacheManager.cacheImage(testImage, for: testURL)
        
        // Retrieve the image
        let cachedImage = cacheManager.getImage(for: testURL)
        XCTAssertNotNil(cachedImage, "Cached image should not be nil")
        XCTAssertEqual(cachedImage?.pngData(), testImage.pngData(), "Cached image data should match original")
    }

    func testImageCachingWithInvalidData() {
        let cacheManager = ImageCacheManager.shared
        let invalidURL = "https://example.com/invalid.jpg"
        
        // Attempt to retrieve an image that was never cached
        let cachedImage = cacheManager.getImage(for: invalidURL)
        XCTAssertNil(cachedImage, "Cached image should be nil for invalid data")
    }

}
