//
//  ViewController.swift
//  ClassicTableView
//
//  Created by alkadios on 2/6/21.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
   
    
    @IBOutlet weak var tblView: UITableView!
    
    let presidentNames = ["George Washington","John Adams","Thomas jefferson","James   Madison","Andrew jackson","George Washington","John Adams","Thomas jefferson","James Madison","Andrew jackson","George Washington","John Adams","Thomas jefferson","James Madison","Andrew jackson"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.delegate = self
        tblView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presidentNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell" ,for: indexPath)
            cell.textLabel?.text = presidentNames[indexPath.row]
            return cell
    }
    
    
}
