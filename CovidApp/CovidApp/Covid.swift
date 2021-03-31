//
//  Covid.swift
//  CovidApp
//
//  Created by alkadios on 3/30/21.
//

import Foundation

class Covid {
    
    var state: String = ""
    var total: Int = 0
    var positive: Int = 0
    
    init(state:String,total:Int,positive:Int){
        
        self.state = state
        self.total = total
        self.positive = positive
    }
}
