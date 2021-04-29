//
//  CampusEventsController.swift
//  Yammer
//
//  Created by alkadios on 4/28/21.
//

import UIKit
import FirebaseAuth

class CampusEventsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logoutAct(_ sender: Any) {
    
          do {
            try Auth.auth().signOut()
            KeychainService().keyChain.delete("uid")
            self.navigationController?.popToRootViewController(animated: true)
            
        } catch{
            print (error)
            
        }
    }
    

}
