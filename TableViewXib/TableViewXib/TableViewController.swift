//
//  TableTableViewController.swift
//  TableViewXib
//
//  Created by alkadios on 2/16/21.
//

import UIKit

class TableTableViewController: UITableViewController {
    
    let cities = ["Seattle","Portland","Diego","SFO","LA","NewYork","Miami","California","Texas","Forida","Georgia","Alaska","Arizona","Nevada","hawai","ohio","Wisconsin","Alabama","colarado","North Carolina","Indiana","Montana"]
    
    let temperatures =  ["29","19","14","15","87","60","50","19","15","10","11","37","40","29","19","14","15","87","15","10","11","37"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }


   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell",owner: self,options: nil)?.first as! TableViewCell
        
        cell.lblcities.text = cities[indexPath.row]
        
        cell.lblTemperatures.text = temperatures[indexPath.row]

         

        return cell
    }
    
    
    

}
