import XCTest
@testable import ElisfotTestingProject

final class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        viewModel = HomeViewModel(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    // MARK: - Test: Add in case Empty Section
    func testAddImageInCaseEmptySection() async {
        // Given
        let expectation = expectation(description: "Completion handler called")
        viewModel.images = [
            
        ]
        // When
        viewModel.addNewImage {
            expectation.fulfill()
        }
        
        // Then
        await fulfillment(of: [expectation])
        let isCacheSucess = CacheManager.shared.getCachedImage(forKey: viewModel.images.first?.data.first?.imageLink ?? "")
        
        XCTAssertTrue(viewModel.images.count == 1, "Images section array should have one item")
        XCTAssertTrue(viewModel.images.first?.data.count == 1, "Images first section should have one item")
        XCTAssertNotNil(viewModel.images.first?.data.first?.imageLink , "Images first section should have one item")
        XCTAssertNotNil(isCacheSucess, "Image should be cached into cache manager")
    }
    
    // MARK: - Test: Add in case Exist Section
    func testAddImageInCaseExistSection() async {
        // Given
        let sectionIndex = 0
        let firstItemIndex = 1
        let expectation = expectation(description: "Completion handler called")
        viewModel.images = [
            ImageSection(data: [Image(imageLink: "http://example.com/image.jpg")])
        ]
        CacheManager.shared.cacheImage(UIImage(), forKey: "http://example.com/image.jpg")
        
        // When
        viewModel.addNewImage {
            expectation.fulfill()
        }
        
        // Then
        await fulfillment(of: [expectation])

        let isCacheSuccess = viewModel.images.indices.contains(sectionIndex) &&
            viewModel.images[sectionIndex].data.indices.contains(firstItemIndex) &&
        CacheManager.shared.getCachedImage(forKey: viewModel.images[sectionIndex].data[firstItemIndex].imageLink ?? "") != nil

        XCTAssertTrue(viewModel.images.count == 1, "Images section should keep 1")
        XCTAssertTrue(viewModel.images[sectionIndex].data.count == 2, "Images first section should have two items")
        XCTAssertNotNil(viewModel.images[sectionIndex].data[firstItemIndex].imageLink, "The second image in the first section should have a valid image link")
        XCTAssertTrue(isCacheSuccess, "Image should be cached into cache manager")
    }

    // MARK: - Test: Add in case Full Section
    func testAddImageInCaseFullSection() async {
        // Given
        let newSectionIndex = 1
        let newItemIndex = 0

        let expectation = expectation(description: "Completion handler called")
        viewModel.images = [
            ImageSection(data: [
                Image(imageLink: "http://example.com/image.jpg"),
                Image(imageLink: "http://example.com/image.jpg"),
                Image(imageLink: "http://example.com/image.jpg"),
                Image(imageLink: "http://example.com/image.jpg"),
                Image(imageLink: "http://example.com/image.jpg"),
                Image(imageLink: "http://example.com/image.jpg"),
                Image(imageLink: "http://example.com/image.jpg")
            ])
        ]
        CacheManager.shared.cacheImage(UIImage(), forKey: "http://example.com/image.jpg")
        
        // When
        viewModel.addNewImage {
            expectation.fulfill()
        }
        
        // Then
        await fulfillment(of: [expectation])
        let isCacheSuccess = viewModel.images.indices.contains(newSectionIndex) &&
            viewModel.images[newSectionIndex].data.indices.contains(newItemIndex) &&
        CacheManager.shared.getCachedImage(forKey: viewModel.images[newSectionIndex].data[newItemIndex].imageLink ?? "") != nil

        XCTAssertTrue(viewModel.images.count == 2, "Images section count should be 2")
        XCTAssertTrue(viewModel.images[newSectionIndex].data.count == 1, "The second section should have one item")
        XCTAssertNotNil(viewModel.images[newSectionIndex].data[newItemIndex].imageLink, "The first image in the second section should have a valid image link")
        XCTAssertTrue(isCacheSuccess, "Image should be cached into cache manager")
    }
    
    // MARK: - Test: Clear Cache
    func testClearImageCache() {
        // Given
        viewModel.images = [
            ImageSection(data: [Image(imageLink: "http://example.com/image.jpg")])
        ]
        CacheManager.shared.cacheImage(UIImage(), forKey: "http://example.com/image.jpg")
        
        // When
        viewModel.clearCache()
        
        // Then
        XCTAssertTrue(viewModel.images.isEmpty, "Images array should be empty")
        XCTAssertNil(CacheManager.shared.getCachedImage(forKey: "http://example.com/image.jpg"), "Cache should be cleared")
        XCTAssertTrue(mockNetworkManager.allRequestsCanceled, "All network requests should be canceled")
    }
    
}
