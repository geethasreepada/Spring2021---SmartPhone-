//
//  Forecast.swift
//  WorldWeather
//
//  Created by alkadios on 3/7/21.
//

import Foundation
import UIKit

var globalImage:UIImage? = UIImage(named: "11-s")

class Forecast{
    
    
    var min:Int = 0
    
    var max:Int = 0
    
    var Day:String = ""
    
    var minIcon:Int = 0
    var maxIcon:Int = 0
    
    var minIconImg: UIImage? = UIImage(named: "12-s") ?? globalImage!
    var maxIconImg: UIImage? = UIImage(named: "12-s") ?? globalImage!
    

    
        
    init(min:Int,max:Int,Day:String,minIcon:Int,maxIcon:Int,minIconImg:UIImage,maxIconImg:UIImage){
        
        self.min = min
        self.max = max
        self.Day = Day
        self.minIcon = minIcon
        self.maxIcon = maxIcon
        self.minIconImg = minIconImg
        self.maxIconImg = maxIconImg
        
    
        
        
    }
    
    
}
