//
//  NetworkManagerTest.swift
//  ElisfotTestingProjectTests
//
//  Created by Neo Truong on 8/28/24.
//

import Foundation
import XCTest
@testable import ElisfotTestingProject

class NetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManager!

    override func setUp() {
        super.setUp()
        networkManager = NetworkManager()
    }

    override func tearDown() {
        networkManager.cancelAllRequests()
        networkManager = nil
        super.tearDown()
    }
    
    func testFetchDataWithValidURLConstant() {
        XCTAssertEqual(NetworkManager.urlString, "https://loremflickr.com/200/200/")
    }

    func testFetchDataWithValidURL() {
        let expectation = self.expectation(description: "Data fetched successfully")
        
        networkManager.fetchData { (baseModel, error) in
            XCTAssertNotNil(baseModel, "Data should not be nil")
            XCTAssertNil(error, "Error should be nil")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchDataWithValidModel() {
        let expectation = self.expectation(description: "Data fetched successfully")
        
        networkManager.fetchData { (baseModel, error) in
            XCTAssertNotNil(baseModel as? ResponseImage, "Data should map to Response Image")
            XCTAssertNil(error, "Error should be nil")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }


    func testFetchDataWithInvalidURL() {
        let expectation = self.expectation(description: "Invalid URL error")
        
        networkManager.fetchData(from: "http://\n.com") { (baseModel, error) in
            XCTAssertNil(baseModel, "Data should be nil for an invalid URL")
            XCTAssertNotNil(error, "Error should not be nil")
            XCTAssertEqual((error as? NetworkError)?.localizedDescription, "The URL provided was invalid.")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: .infinity, handler: nil)
    }
    
    func testFetchDataWithNodata() {
        let expectation = self.expectation(description: "Invalid URL error")
        
        networkManager.fetchData(from: "somewrongURL") { (baseModel, error) in
            XCTAssertNil(baseModel, "Data should be nil for an invalid URL")
            XCTAssertNotNil(error, "Error should not be nil")
            XCTAssertEqual((error as? NetworkError)?.localizedDescription, "No data was received from the server.")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: .infinity, handler: nil)
    }

    func testCancelAllRequests() {
        let expectation = self.expectation(description: "Request canceled")

        networkManager.fetchData { (baseModel, error) in
            expectation.fulfill()
        }
        
        networkManager.cancelAllRequests()
        XCTAssertEqual(self.networkManager.activeTasks.count, 0)
        waitForExpectations(timeout: .infinity, handler: nil)
    }
}
