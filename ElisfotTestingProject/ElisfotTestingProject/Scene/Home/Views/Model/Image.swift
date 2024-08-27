//
//  Image.swift
//  ElisfotTestingProject
//
//  Created by Neo Truong on 8/26/24.
//

import Foundation

protocol BaseModel {
    
}

struct Image {
    let imageLink: String?
    
    init(imageLink: String?) {
        self.imageLink = imageLink
    }
    
    init() {
        self.imageLink = nil
    }
}

struct ResponseImage: BaseModel {
    let imageLink: String
    let data: Data
}


struct ImageSection {
    var data: [Image]
}
