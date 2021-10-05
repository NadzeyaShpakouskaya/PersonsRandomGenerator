//
//  CachedImageView.swift
//  PersonsRandomGenerator
//
//  Created by Nadzeya Shpakouskaya on 03/10/2021.
//

import UIKit

class CachedImageView: UIImageView {

    func fetchImage(from url: String) {
        guard let url = URL(string: url) else { return }
        
        //If we have cached image, use it
        if let cachedImage = getCachedImage(from: url) {
            image = cachedImage
            return
        }
        
        // If we don't have cached image, load from api
        ImageManager.shared.fetchImage(from: url) { data, response in
            self.image = UIImage(data: data)
            self.saveDataToCache(with: data, and: response)
        }
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }

}
