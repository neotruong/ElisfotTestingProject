import XCTest
@testable import ElisfotTestingProject

final class HomeViewControllerTests: XCTestCase {
    
    var viewModel: MockHomeViewModel!
    var viewController: HomeViewController!
    
    override func setUp() {
        super.setUp()
        viewModel = MockHomeViewModel()
        viewController = HomeViewController(viewModel: viewModel)
        _ = viewController.view
    }
    
    override func tearDown() {
        viewModel = nil
        viewController = nil
        super.tearDown()
    }
    
    // MARK: - Test: Initialization
    func testViewControllerInitialization() {
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewController.view)
        
        XCTAssertNotNil(viewController.collectionView)
    }
    
    // MARK: - Test: ViewDidLoad
    func testViewDidLoad_Setup() {
        XCTAssertTrue(viewController.collectionView.delegate === viewController)
        XCTAssertTrue(viewController.collectionView.dataSource === viewController)
        XCTAssertTrue(viewController.collectionView.isPagingEnabled)
        XCTAssertEqual(viewController.navigationItem.leftBarButtonItems?.count, 2)
    }
    
    // MARK: - Test: AddButtonTapped
    func testAddButtonTapped() {
        // Given
        viewModel.images = []
        
        // When
        viewController.addButtonTapped()
        
        // Then
        XCTAssertTrue(viewModel.addNewImageCalled)
        XCTAssertEqual(viewController.images.count, 1)
    }
    
    // MARK: - Test: ReloadButtonTapped
    func testReloadButtonTapped() {
        // Given
        viewModel.images = [
            ImageSection(data: [Image(imageLink: "http://example.com/image.jpg")])
        ]
        
        // When
        viewController.reloadButtonTapped()
        
        // Then
        XCTAssertEqual(viewModel.images.count, viewController.reloadValue / 7)
        XCTAssertEqual(viewModel.images.flatMap { $0.data }.count, viewController.reloadValue)
    }
    
    // MARK: - Test: CollectionView DataSource
    func testCollectionViewDataSource() {
        // Given
        viewModel.images = [
            ImageSection(data: [Image(imageLink: "http://example.com/image.jpg")])
        ]
        viewController.images = viewModel.images
        
        // When
        let numberOfItems = viewController.collectionView(viewController.collectionView, numberOfItemsInSection: 0)
        
        // Then
        XCTAssertEqual(numberOfItems, 1)
    }
    
    func testCollectionViewCellForItem() {
        // Given
        viewModel.images = [
            ImageSection(data: [Image(imageLink: "http://example.com/image.jpg")])
        ]
        viewController.images = viewModel.images
        
        // When
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = viewController.collectionView(viewController.collectionView, cellForItemAt: indexPath) as? SectionCollectionCell
        
        // Then
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.images.count, 1)
    }
}
