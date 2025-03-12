//
//  ImageCacheManager.swift
//  FetchTakeHomeProject
//
//  Created by Chux Ugonabo MacBook on 2025-02-10.
//

import Foundation
import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let cache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    private init() {
        cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
    
    func getImage(for urlString: String) -> UIImage? {
        if let image = cache.object(forKey: urlString as NSString) {
            return image
        }
        
        let fileURL = cacheDirectory.appendingPathComponent(urlString.hash.description)
        do {
            let data = try Data(contentsOf: fileURL)
            if let image = UIImage(data: data) {
                cache.setObject(image, forKey: urlString as NSString)
                return image
            }
        } catch {
            print("Failed to load image from disk: \(error.localizedDescription)")
        }
        return nil
    }
    
    func cacheImage(_ image: UIImage, for urlString: String) {
        cache.setObject(image, forKey: urlString as NSString)
        let fileURL = cacheDirectory.appendingPathComponent(urlString.hash.description)
        do {
            if let data = image.jpegData(compressionQuality: 1.0) {
                try data.write(to: fileURL)
            }
        } catch {
            print("Failed to write image to disk: \(error.localizedDescription)")
        }
    }
}
