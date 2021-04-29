//
//  PickerViewController.swift
//  Yammer
//
//  Created by alkadios on 4/28/21.
//
import UIKit

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var txtCategories: UITextField!
    

    
    let arr = [ "Beverages",
                "Breakfast",
                "Chocolates",
                "Fruits",
                "Household",
                "Jams",
                "Readymeals"
    ]
    
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        txtCategories.inputView = pickerView
        

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return arr.count
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        txtCategories.text = arr[row]
        txtCategories.resignFirstResponder()
    }

}
