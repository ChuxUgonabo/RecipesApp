//
//  ImageLoader.swift
//  FetchTakeHomeProject
//
//  Created by Chux Ugonabo MacBook on 2025-02-10.
//

import Foundation
import UIKit

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var urlString: String?
    
    func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        self.urlString = urlString
        
        if let cachedImage = ImageCacheManager.shared.getImage(for: urlString) {
            image = cachedImage
            return
        }
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    await MainActor.run {
                        self.image = image
                        ImageCacheManager.shared.cacheImage(image, for: urlString)
                    }
                }
            } catch {
                print("Image loading failed: \(error.localizedDescription)")
            }
        }
    }
}
