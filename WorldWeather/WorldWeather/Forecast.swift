//
//  Forecast.swift
//  WorldWeather
//
//  Created by alkadios on 3/7/21.
//

import Foundation

class Forecast{
    
    
    var min:Int = 0
    
    var max:Int = 0
    
    var Day:String = ""
    
    
    init(min:Int,max:Int,Day:String){
        
        self.min = min
        self.max = max
        self.Day = Day
        
    }
    
    
}
