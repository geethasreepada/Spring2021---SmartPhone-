//
//  PaymentDetailsCell.swift
//  Yammer
//
//  Created by alkadios on 4/29/21.
//

import UIKit

class PaymentDetailsCell: UITableViewCell {

    @IBOutlet weak var lblNUID: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblSem: UILabel!
    
    @IBOutlet weak var lblTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
