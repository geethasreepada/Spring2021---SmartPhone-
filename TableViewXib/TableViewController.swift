//
//  TableTableViewController.swift
//  TableViewXib
//
//  Created by alkadios on 2/16/21.
//

import UIKit

class TableTableViewController: UITableViewController {
    
    let cities = ["Seattle","Portland","Diego","SFO","LA","NewYork","Miami"]

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell",owner: self,options: nil)?.first as! TableViewCell
        
        cell.lblcities.text = cities[indexPath.row]
         
        // Configure the cell...

        return cell
    }
    

}
