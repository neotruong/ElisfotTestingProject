//
//  CacheManager.swift
//  ElisfotTestingProject
//
//  Created by Neo Truong on 8/26/24.
//

import Foundation
import UIKit

class CacheManager {

    static let shared = CacheManager()
    
    private let imageCache = NSCache<NSString, UIImage>()

    private init() {}

    func cacheImage(_ image: UIImage, forKey key: String) {
        guard getCachedImage(forKey: key) == nil else {
            return
        }
        imageCache.setObject(image, forKey: key as NSString)
    }

    func getCachedImage(forKey key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }

    func removeCachedImage(forKey key: String) {
        imageCache.removeObject(forKey: key as NSString)
    }

    func clearCache() {
        imageCache.removeAllObjects()
    }
}
