//
//  NewsHeadlinesTableViewController.swift
//  NewsHeadlines
//
//  Created by alkadios on 2/23/21.
//

import UIKit

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner


class NewsHeadlinesTableViewController: UITableViewController {
    
    @IBOutlet var tblNews: UITableView!
    var newsArray : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cell = Bundle.main.loadNibNamed("NewsHeadlinesTableViewCell", owner: self, options: nil)?.first as! NewsHeadlinesTableViewCell

        cell.lblTitle.text = newsArray[indexPath.row]
        
        return cell
    }
    

    func getUrl() -> String{
        var url = apiURL
        url.append(apiKey)
        return url
    }
    
    func getData() {
        let url = getUrl()
          print(url)
        AF.request(url).responseJSON { (response) in
            print(response)

            if response.error == nil {
                
                guard let data = response.data else { return }
                
                 if let json = try? JSON(data : data) {
                    for article in json["articles"].arrayValue {
                        print(article["title"].stringValue)
                        self.newsArray.append(article["title"].stringValue)
                    }
                }
                self.tblNews.reloadData()
                
            }
        }
    }

}


