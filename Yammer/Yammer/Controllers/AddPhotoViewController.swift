//
//  AddPhotoViewController.swift
//  Yammer
//
//  Created by alkadios on 4/28/21.
//
import Foundation
import UIKit
import FirebaseFirestore
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    var db: Firestore!
    
    
    
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var ImgComp: UIImageView!
    
    @IBOutlet weak var txtName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = FirestoreSettings()

                Firestore.firestore().settings = settings
                
                db = Firestore.firestore()
               lblStatus.text = ""

    }
   
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
        {
            if let pickedImage = info[.originalImage] as? UIImage{
                ImgComp.image = pickedImage
            }
            picker.dismiss(animated: true, completion: nil)
        }
    @IBAction func selectAction(_ sender: Any) {
          if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.allowsEditing = false
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
        
      
    }
    
    
    @IBAction func exit(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            KeychainService().keyChain.delete("uid")
            self.navigationController?.popToRootViewController(animated: true)
            
        } catch{
            print (error)
            
        }
    }
    
    @IBAction func uploadAction(_ sender: Any) {
             let name = txtName.text
                
                if name == "" {
                    return
                }
                
                let storageRef = Storage.storage().reference()
                let data = ImgComp.image?.pngData()
        
                

                let categoryRef = storageRef.child("categories/" + name! + ".png")

                
                let uploadTask = categoryRef.putData(data!, metadata: nil) { (metadata, error) in
           
                    if error != nil {
                        print(error?.localizedDescription)
                        return
                    }
                    
                    categoryRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                      return
                    }
                        
                    print(downloadURL)
                        
                        
                        self.navigationController?.popViewController(animated: true)
                        //self.lblStatus.text = "Yayy!!Picture uploaded"
                    
                  }
                }
                
            }
                
            }
    
    

