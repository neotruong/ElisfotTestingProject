//
//  MockHomeViewModel.swift
//  ElisfotTestingProjectTests
//
//  Created by Neo Truong on 8/28/24.
//
@testable import ElisfotTestingProject
import Foundation


final class MockHomeViewModel: HomeViewModelDelegated {
    var images: [ImageSection] = []
    var addNewImageCalled = false
    var clearCacheCalled = false
    
    func addNewImage(onFinish: @escaping (() -> Void)) {
        addNewImageCalled = true
        if images.isEmpty {
            images.append(ImageSection(data: [Image(imageLink:  "mockImageLink")]))
        } else if images.last!.data.count == 7 {
            images.append(ImageSection(data: [Image(imageLink:  "mockImageLink")]))
        } else {
            images[images.count - 1].data.append(Image(imageLink:  "mockImageLink"))
        }
        onFinish()
    }
    
    func clearCache() {
        clearCacheCalled = true
        images = []
    }
}
