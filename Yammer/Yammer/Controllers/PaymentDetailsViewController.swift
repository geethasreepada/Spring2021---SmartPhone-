//
//  PaymentDetailsViewController.swift
//  Yammer
//
//  Created by alkadios on 4/29/21.
//

import UIKit
import Firebase
import FirebaseDatabase


class PaymentDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var payTblView: UITableView!
    var paymentDetails = [PaymentDetailsModel]()
    var db:Firestore!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = Bundle.main.loadNibNamed("PaymentDetailsCell", owner: self, options: nil)?.first as! PaymentDetailsCell
              //cell.backgroundColor = UIColor.clear
         if (indexPath.row % 2 == 0) {
          cell.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        }else{
            cell.backgroundColor = UIColor.white
        }

    
        cell.lblName.text = "\(paymentDetails[indexPath.row].Name)"
                
                cell.lblNUID.text = "\(paymentDetails[indexPath.row].NUID)"
                cell.lblSem.text = "\(paymentDetails[indexPath.row].Semester)"
        cell.lblTotal.text = "\(paymentDetails[indexPath.row].actualFee)"
               // cell.lblPaymentID.text = "\(paymentDetails[indexPath.row].paymentID)"
    
                return cell
    }
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()

        payTblView.dataSource = self
        payTblView.delegate = self
        
        getfinalpayDetails()

       
    }
    

    func getfinalpayDetails(){
        
        db.collection("Final Payment Details")
            .getDocuments(){(querySnapshot,err) in
            
                if err != nil{
            print(err?.localizedDescription ?? "Error in getting payment Details")
            return
        }
        
        for document in querySnapshot!.documents {
            let data = document.data()
            let name = data["Name"] as! String
            let NUID = data["NUID"] as! String
            let sem = data["Semester"] as! String
            let actualFee = data["Actual Amount"] as! String
            let totalAmountPaid:String = data["Total Amount paid"] as? String ?? "None"
            let paymentID = data["userID"] as! String
            
            print(name)
            let output = PaymentDetailsModel (Name:name,NUID:NUID,Semester:sem,actualFee:actualFee,TotalAmountPaid:totalAmountPaid,paymentID:paymentID
            )
            self.paymentDetails.append(output)
            
        }
        
                self.payTblView.reloadData()
    }

        }
        
        
    
    @IBAction func loggout(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            KeychainService().keyChain.delete("uid")
            self.navigationController?.popToRootViewController(animated: true)
            
        }
        catch{
            print (error)
            
        }
        
    }
    
    }


