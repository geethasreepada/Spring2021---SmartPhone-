//
//  ProductViewController.swift
//  Yammer
//
//  Created by alkadios on 4/29/21.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseFirestore

class ProductViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var db:Firestore!
    @IBOutlet weak var productTblView: UITableView!
    var ProductsArray:[NEUProducts] = [NEUProducts]()
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = Bundle.main.loadNibNamed("ProductTableViewCell", owner: self, options: nil)?.first as! ProductTableViewCell

        
        //cell.configure(with: ProductsArray[indexPath.row])
        cell.lblSub.text = "\(ProductsArray[indexPath.row].sub)"
        cell.lblGPA.text = "\(ProductsArray[indexPath.row].gpa)"
        //cell.ImgProduct.image = UIImage(named: ProductsArray[indexPath.row].Image)
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        productTblView.rowHeight = UITableView.automaticDimension
        productTblView.estimatedRowHeight = 470
        
        productTblView.register(ProductTableViewCell.nib(), forCellReuseIdentifier: ProductTableViewCell.identifier)
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        productTblView.dataSource = self
        productTblView.delegate = self
        
        getProductsData()

    }
    
    
    func getProductsData(){
        
        db.collection("Transcript").getDocuments(){(QuerySnapshot,err) in
            if err != nil {
                
                print(err?.localizedDescription ?? "Error in getting Products")
                return
            }
            
            for document in QuerySnapshot!.documents{
                let data = document.data()
                let subject = data["Sub"] as! String
                let gpa = data["GPA"] as! String
                
                let output = NEUProducts(sub:subject,gpa:gpa
                )
                self.ProductsArray.append(output)
                
            }
            
            self.productTblView.reloadData()
        }
    }
    
    
    
    @IBAction func logoutBtn(_ sender: Any) {
    
        
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
        
        



