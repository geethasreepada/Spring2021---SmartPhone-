//
//  CommoditiesTableViewController.swift
//  PromisesWithRestAPICalls
//
//  Created by alkadios on 2/26/21.
//
import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import PromiseKit

class CommoditiesTableViewController: UITableViewController {

    @IBOutlet var tblCommodities: UITableView!
    
    var commoditiesArray : [Commodities] = [Commodities]()
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
           getData()
       }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return commoditiesArray.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = Bundle.main.loadNibNamed("CommoditiesTableViewCell", owner: self, options: nil)?.first as! CommoditiesTableViewCell
                
                cell.lblName.text = commoditiesArray[indexPath.row].name
                
                cell.lblPrice.text = "$\(commoditiesArray[indexPath.row].price)"

                return cell
            }
            
        // Configure the cell...

    
    
    
    func getUrl() -> String{
            var url = apiURL
            url.append(apiKey)
            return url
        }
        
    
            
    func getQuickShortQuote(URL : String) -> Promise<[Commodities]>{
        
        return Promise<[Commodities]> { seal -> Void in
                    
                    AF.request(URL).responseJSON { response in
                        if response.error == nil {
                
                            var arr  = [Commodities]()
                            guard let data = response.data else {return seal.fulfill( arr ) }
                            guard let commodities = JSON(data).array else { return  seal.fulfill( arr ) }
                            
                            for commodity in commodities {
                                
                                let name = commodity["name"].stringValue
                                let price = commodity["price"].floatValue
                                
                                let commodity = Commodities(name: name,price: price)
                                commodity.name = name
                                commodity.price = price
                                arr.append(commodity)
                            }
                            
                            seal.fulfill(arr)
                        }
                        else {
                            seal.reject(response.error!)
                        }
                    }// end of AF request
    
        }
    }
        
       func getData(){
            
            
            
            let URL = getUrl()

            
            getQuickShortQuote(URL: URL)
                                    .done { (commodities) in
                            self.commoditiesArray = [Commodities]()
                            for commodity in commodities {
                                self.commoditiesArray.append(commodity)
                            }
                                        self.tblCommodities.reloadData()

                        }
                        .catch { (error) in
                            print("Error in getting all the stock values \(error)")
                        }
                }// end of function
            
        }
        
        

