//
//  BookSlotViewController.swift
//  Yammer
//
//  Created by alkadios on 4/27/21.
//

import UIKit
import SAConfettiView
import Firebase
import FirebaseFirestore
import FirebaseDatabase
import FirebaseStorage



class BookSlotViewController: UIViewController {
    
    
    
    @IBOutlet weak var NUIDtxt: UITextField!
    @IBOutlet weak var Nametxt: UITextField!
    
    @IBOutlet weak var lblSubmit: UILabel!
    
    
    
    @IBOutlet weak var txtEmail: UITextField!
    
    var db: Firestore!
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        self.lblSubmit.text = ""

        
    }
    
    @IBAction func logout(_ sender: Any) {
        
       
            
            do {
                try Auth.auth().signOut()
                KeychainService().keyChain.delete("uid")
                self.navigationController?.popToRootViewController(animated: true)
                
            } catch{
                print (error)
                
            }
        }
    
    
     @IBAction func SubmitAction(_ sender: UIButton) {
        
        var message:String = ""
        
        let email = txtEmail.text!
        let Name = Nametxt.text!
        let NUID = NUIDtxt.text!
        
        
        if email == "" || Name == "" || (NUID != nil) == false {
            lblSubmit.text = "Please enter valid details"
            return
        }
        
        if email.isEMail == false {
            lblSubmit.text = "Please enter valid Email"
            return
        }
        
        else{
            
            lblSubmit.text = "Yayy! Your slot is booked.A confirmation email will be sent to you within 24 hours"
            
            message = "Yayy! Your slot is booked"
            addStudentDetailsToDB()
            
            
    

            
            let alertController:UIAlertController = UIAlertController(title: "Message", message: message, preferredStyle: UIAlertController.Style.alert)
                    
                    
                    let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
                    
                    
                    alertController.addAction(alertAction)
                    present(alertController, animated: true, completion: nil)
            
                      
        }
     }
    
    func addStudentDetailsToDB(){
        
        let newDetails = db.collection("StudentDetails").document()
        let detailsID = newDetails.documentID
        
       
                let uid = Auth.auth().currentUser?.uid
        
                
        newDetails.setData([         "userID": uid!,
                                     "Name": Nametxt.text!,
                                     "NUID": NUIDtxt.text!,
                                     "email": txtEmail.text!,
                                     "DetailsID":detailsID
                                     
                                     
                ])
    }
    

}

