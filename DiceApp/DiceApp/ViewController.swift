//
//  ViewController.swift
//  DiceApp
//
//  Created by alkadios on 1/28/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var lblWinLoose: UILabel!

    @IBOutlet weak var lblBalance: UILabel!
    
    @IBOutlet weak var lblButton: UIButton!
    
    let imageArray = ["Dice1","Dice2","Dice3","Dice4","Dice5","Dice6"]
    
    
    
    var random1 = arc4random_uniform(6) + 1
            
        var random2 = arc4random_uniform(6) + 1
    
    var balance = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeImages()
        lblWinLoose.text = "Please tap Play button"
        lblBalance.text = "Your balance is \(balance)$"
        
        // Do any additional setup after loading the view.
    }

    func changeImages(){
        random1 = arc4random_uniform(6) + 1
        random2 = arc4random_uniform(6) + 1
        
        
        image1.image = UIImage(named:"Dice\(random1)")
        image2.image = UIImage(named:"Dice\(random2)")
        
        
        
        
}

    
    
    @IBAction func playButton(_ sender: Any) {
        changeImages()
        
        if random1 + random2 == 7
        
        {
        balance = balance + 3
           lblBalance.text = "Your balance is \(balance)$"
        
    }
        else if random1 + random2 < 7
        {
        
        balance = balance-1
            lblWinLoose.text = "You loose 1$"

        lblBalance.text = "Your balance is \(balance)$"
        
    }
        else {
            balance = balance+1
            lblWinLoose.text = "You won 1$"
            lblBalance.text = "Your balance is \(balance)$"

        }
        
        lblBalance.text = "Your balance = \(balance)$"
        
        if balance <= 0 {
            lblButton.isEnabled = false
            lblWinLoose.text = "Please restart app"
            lblBalance.text = "Oops!No balance $"
        }
    
    }}
