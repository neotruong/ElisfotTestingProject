//
//  HomeViewModel.swift
//  ElisfotTestingProject
//
//  Created by Neo Truong on 8/26/24.
//

import Foundation
import UIKit

protocol HomeViewModelDelegated {
    func addNewImage(onFinish: @escaping (() -> Void))
    func clearCache()
    
    var images: [ImageSection] { get }
}

final class HomeViewModel: HomeViewModelDelegated {
    var images: [ImageSection] = []
    var networkManager: NetworkManager!
    
    init(networkManager: NetworkManager!) {
        self.networkManager = networkManager
    }
    
    func addNewImage(onFinish: @escaping (() -> Void)){
        networkManager.fetchData(completion: { [weak self] response,_ in
            guard let response = response as? ResponseImage else {
                return
            }
            guard let self = self else {
                return
            }
            if self.images.count == 0 {
                self.images.append(ImageSection(data: [Image(imageLink: response.imageLink)]))
            } else if images.last!.data.count == 7 {
                self.images.append(ImageSection(data: [Image(imageLink: response.imageLink)]))
            } else {
                self.images[images.count - 1].data.append(Image(imageLink: response.imageLink))
            }
            
            CacheManager.shared.cacheImage(UIImage(data: response.data)!, forKey: response.imageLink)
            onFinish()
            
        })
    }
    
    func clearCache() {
        CacheManager.shared.clearCache()
        networkManager.cancelAllRequests()
        images = []
       
    }
}

