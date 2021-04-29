//
//  ProductCategoryModel.swift
//  Yammer
//
//  Created by alkadios on 4/26/21.
//

import Foundation


class ProductCategoryModel{
    
    var categoryID: String = ""
    var name: String = ""
    var image: String = ""
    
    init(_ categoryID: String, _ name: String, _ image: String) {
        self.categoryID = categoryID
        self.name = name
        self.image = image
    }

    
}
