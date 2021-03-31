//
//  ViewController.swift
//  CovidApp
//
//  Created by alkadios on 3/30/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import PromiseKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var covidTbl: UITableView!
    
    var covidArray:[Covid] = [Covid]()

    override func viewDidLoad() {
        super.viewDidLoad()
        covidTbl.delegate = self
        covidTbl.dataSource = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
           getCovidData()
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return covidArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("CovidTableViewCell", owner: self, options: nil)?.first as! CovidTableViewCell
        if (indexPath.row % 2 == 0) {
         cell.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
       }else{
           cell.backgroundColor = UIColor.white
       }
        cell.lblState.text = "\(covidArray[indexPath.row].state)"
        cell.lbltotal.text = "\(covidArray[indexPath.row].total)"
        cell.lblPositive.text = "\(covidArray[indexPath.row].positive)"

        
        return cell
    }
    

    func getCovidURL ()->String{
        let url = covidDataUrl
        
        return url
        
    }

    func getQuickShortQuote(URL : String) -> Promise<[Covid]>{
        
        return Promise<[Covid]> { seal -> Void in
                    
                    AF.request(URL).responseJSON { response in
                        if response.error == nil {
                
                            var arr  = [Covid]()
                            guard let data = response.data else {return seal.fulfill( arr ) }
                            guard let covid = JSON(data).array else { return  seal.fulfill( arr ) }
                            
                            for covidData in covid {
                                
                                let state = covidData["state"].stringValue
                                let total = covidData["total"].intValue
                                let positives = covidData["positive"].intValue
                                let covidValues = Covid(state: state,total: total,positive:positives)
                                covidValues.state = state
                                covidValues.total = total
                                covidValues.positive = positives
                                arr.append(covidValues)
                            }
                            
                            seal.fulfill(arr)
                        }
                        else {
                            seal.reject(response.error!)
                        }
                    }
    
        }
    }
        
       func getCovidData(){
            
            
            
            let URL = getCovidURL()

            
            getQuickShortQuote(URL: URL)
                                    .done { (covid) in
                            self.covidArray = [Covid]()
                                        for covidUnits in covid {
                                            self.covidArray.append(covidUnits)
                            }
                                        self.covidTbl.reloadData()

                        }
                        .catch { (error) in
                            print("Error in getting all the stock values \(error)")
                        }
                }

}
