//
//  CacheManagerTest.swift
//  ElisfotTestingProjectTests
//
//  Created by Neo Truong on 8/28/24.
//

import Foundation
import XCTest
@testable import ElisfotTestingProject

class CacheManagerTests: XCTestCase {
    
    var cacheManager: CacheManager!

    override func setUp() {
        super.setUp()
        cacheManager = CacheManager.shared
    }

    override func tearDown() {
        cacheManager.clearCache() // Clear cache after each test
        cacheManager = nil
        super.tearDown()
    }

    func testCacheImage() {
        let testImage = UIImage()
        let testKey = "testKey"
        
        cacheManager.cacheImage(testImage, forKey: testKey)
        
        let cachedImage = cacheManager.getCachedImage(forKey: testKey)
        
        XCTAssertNotNil(cachedImage, "Image should be cached")
    }

    func testRemoveCachedImage() {
        let testImage = UIImage()
        let testKey = "testKey"
        
        cacheManager.cacheImage(testImage, forKey: testKey)
        cacheManager.removeCachedImage(forKey: testKey)
        
        let cachedImage = cacheManager.getCachedImage(forKey: testKey)
        
        XCTAssertNil(cachedImage, "Image should be removed from cache")
    }

    func testClearCache() {
        let testImage1 = UIImage()
        let testKey1 = "testKey1"
        
        let testImage2 = UIImage()
        let testKey2 = "testKey2"
        
        cacheManager.cacheImage(testImage1, forKey: testKey1)
        cacheManager.cacheImage(testImage2, forKey: testKey2)
        
        cacheManager.clearCache()
        
        XCTAssertNil(cacheManager.getCachedImage(forKey: testKey1), "Cache should be cleared")
        XCTAssertNil(cacheManager.getCachedImage(forKey: testKey2), "Cache should be cleared")
    }
}
