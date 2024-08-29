//
//  NetworkManager.swift
//  ElisfotTestingProject
//
//  Created by Neo Truong on 8/26/24.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case invalidURL
    case networkError(Error)
    case noData
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .networkError(let error):
            return "Network error occurred: \(error.localizedDescription)"
        case .noData:
            return "No data was received from the server."
        }
    }
}

class NetworkManager {
    
    private (set)var activeTasks = [UUID: URLSessionDataTask]()
    static let urlString = "https://loremflickr.com/200/200/"
    
    func fetchData(from urlString: String = NetworkManager.urlString, completion: @escaping (BaseModel?, Error?) -> Void) {
        let uuid = UUID()
        guard let url = URL(string: urlString) else {
            completion(nil, NetworkError.invalidURL)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let self = self else { return }
            guard let data = data else {
                completion(nil, NetworkError.noData)
                return
            }
            self.activeTasks[uuid]?.cancel()
            self.activeTasks.removeValue(forKey: uuid)
            completion(ResponseImage(imageLink: response?.url?.absoluteString ?? "", data: data), error)
        }
        activeTasks[uuid] = task
        
        task.resume()
    }
    
    func cancelAllRequests() {
        for task in activeTasks {
            task.value.cancel()
        }
        activeTasks.removeAll()
    }
}
