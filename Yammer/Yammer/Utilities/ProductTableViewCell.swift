//
//  ProductTableViewCell.swift
//  Yammer
//
//  Created by alkadios on 4/29/21.
//

import UIKit


class ProductTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblGPA: UILabel!
    @IBOutlet weak var lblSub: UILabel!
    static var identifier = "Cell"
    static func nib() ->UINib{
        return UINib(nibName: "ProductTableViewCell", bundle: nil)
    }
   
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
