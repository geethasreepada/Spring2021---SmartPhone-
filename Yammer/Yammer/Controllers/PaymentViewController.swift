//
//  PaymentViewController.swift
//  Yammer
//
//  Created by alkadios on 4/29/21.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseFirestore
class PaymentViewController: UIViewController {
    
    
    
    @IBOutlet weak var txtStdName: UITextField!
    
    @IBOutlet weak var txtNuid: UITextField!

    @IBOutlet weak var txtSem: UITextField!
    
    @IBOutlet weak var txtAmt: UITextField!
    var db: Firestore!
    
    
    @IBOutlet weak var lblpayStatus: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        lblpayStatus.text = ""
       

        
    }

    @IBAction func loggingout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            KeychainService().keyChain.delete("uid")
            self.navigationController?.popToRootViewController(animated: true)
            
        }
        catch{
            print (error)
            
        }
        
    }
        
        
    
    

    @IBAction func PayAction(_ sender: Any) {
    
        
        var message:String = ""
        
        
        let Name = txtStdName.text!
        let NUID = txtNuid.text!
        let Semester = txtSem.text!
        let Amount = txtAmt.text!
        let totalAmount: Int = Int(txtAmt.text!)! + 2
        
        if (Amount != nil) == false || Name == "" || NUID == "" || Semester == ""  {
            lblpayStatus.text = "Please enter valid details"
            return
        }
        
        if Amount < "1" || Amount == "0" {
            lblpayStatus.text = "Please enter proper Amount"
            return
        }
        
        else{
            
            lblpayStatus.text = "Payment Done"
            
            message = "\(totalAmount)$ Paid!"
            addStudentDetailsToDB()
            
            
    

            
            let alertController:UIAlertController = UIAlertController(title: "Message", message: message, preferredStyle: UIAlertController.Style.alert)
                    
                    
                    let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
                    
                    
                    alertController.addAction(alertAction)
                    present(alertController, animated: true, completion: nil)
            
                      
        }
     }
        func addStudentDetailsToDB() {
        
        let newDetails = db.collection("Final Payment Details").document()
        let detailsID = newDetails.documentID
        
       
                let uid = Auth.auth().currentUser?.uid
        
            let Name = txtStdName.text!
            let NUID = txtNuid.text!
            let Semester = txtSem.text!
            let Amount = txtAmt.text!
            let totalAmount: Int = Int(txtAmt.text!)! + 2
        
                
        newDetails.setData([         "userID": uid!,
                                     "Name": txtStdName.text!,
                                     "NUID": txtNuid.text!,
                                     "Semester":txtSem.text!,
                                     "Actual Amount":"\(txtAmt.text!)$",
                                     " Total Amount paid":"\(totalAmount)"
                                       
                                     
                                     
                                     
                                     
                                     
                ])
    }
    

    }

