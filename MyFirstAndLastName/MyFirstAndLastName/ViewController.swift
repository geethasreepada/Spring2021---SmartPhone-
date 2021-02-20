//
//  ViewController.swift
//  MyFirstAndLastName
//
//  Created by alkadios on 1/20/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblPressMe: UILabel!
    

    
    @IBOutlet weak var imgView: UIImageView!
    var firstNameBtn : Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        @IBAction func PressMe(_ sender: Any) {
        
        lblPressMe.text = "Button Pressed"
        
        if firstNameBtn == true{
            firstNameBtn = false
            imgView.image = UIImage(named:"SREEPADA")
            
        }
        else{
            firstNameBtn = true
            imgView.image = UIImage(named:"GEETHA")
        }
}
}

    
    
