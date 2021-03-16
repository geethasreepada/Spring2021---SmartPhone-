//
//  forecastTableViewCell.swift
//  WorldWeather
//
//  Created by alkadios on 3/7/21.
//

import UIKit

class forecastTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMin: UILabel!
    @IBOutlet weak var lblMax: UILabel!
    
    
    @IBOutlet weak var ImgMax: UIImageView!
    
    @IBOutlet weak var ImgMin: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
}
