//
//  MockNetwork.swift
//  ElisfotTestingProjectTests
//
//  Created by Neo Truong on 8/27/24.
//

import Foundation
@testable import ElisfotTestingProject


struct MockResponse: BaseModel {
    var imageLink: String
    var data: Data
}

class MockNetworkManager: NetworkManager {
    
    var mockResponse: MockResponse?
    var allRequestsCanceled = false
    
    func fetchData(completion: @escaping ((MockResponse?, Error?) -> Void)) {
        completion(mockResponse, nil)
    }
   
    override func cancelAllRequests() {
        allRequestsCanceled = true
    }
}
