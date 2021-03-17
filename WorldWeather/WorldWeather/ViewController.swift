//
//  ViewController.swift
//  WorldWeather
//
//  Created by alkadios on 3/5/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import PromiseKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource{
    


    @IBOutlet weak var forecastTbl: UITableView!
    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var lblHigh: UILabel!
    
    @IBOutlet weak var lblLow: UILabel!
    @IBOutlet weak var lblLat: UILabel!
    @IBOutlet weak var lblLng: UILabel!
    
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var lblWther: UILabel!
    
    
    @IBOutlet weak var maxIconImg: UIImageView!
    
    @IBOutlet weak var WeatherIconImg: UIImageView!
    @IBOutlet weak var minIconImg: UIImageView!
    var forecastArray:[Forecast] = [Forecast]()
    
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
               forecastTbl.delegate = self
                forecastTbl.dataSource = self
                locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
                locationManager.requestLocation()
                //self.forecastTbl.backgroundColor = UIColor.clear
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return forecastArray.count
        }
        
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = Bundle.main.loadNibNamed("forecastTableViewCell", owner: self, options: nil)?.first as! forecastTableViewCell
                  //cell.backgroundColor = UIColor.clear
             if (indexPath.row % 2 == 0) {
              cell.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
            }else{
                cell.backgroundColor = UIColor.white
            }

        
                   cell.lblMin.text = "\(forecastArray[indexPath.row].min)°F"
                    
                    cell.lblMax.text = "\(forecastArray[indexPath.row].max)°F"
                    cell.lblDate.text = "\(forecastArray[indexPath.row].Day)"
                    cell.ImgMin.image = UIImage(named:"\(forecastArray[indexPath.row].minIcon)-s")
                    cell.ImgMax.image = UIImage(named:"\(forecastArray[indexPath.row].maxIcon)-s")
        
                    return cell
        
                }
    

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currLocation=locations.last{
            let lng=currLocation.coordinate.longitude
            let lat=currLocation.coordinate.latitude
            
            
//            print("lat:\(lat)")
//            print("lng:\(lng)")
//
            lblLat.text = "lat:\(lat)"
            lblLng.text = "lng:\(lng)"
            
            self.updateLocalWeather(lat,lng)
            
            
            
        }
    }
    func updateLocalWeather(_ lat:CLLocationDegrees,_ lng:CLLocationDegrees){
        let url = getLocationURL(lat, lng)
        
        
        getLocationData(url).done{
            (Key,city) in
            print(Key)
            print("hello")
            print(city)
            
            self.lblCity.text = city
            let fiveDayForecastURL = self.getFiveDayForecastURL(Key)
            self.updateFiveDayData(fiveDayForecastURL).done{ (Rain) in

//                print(Rain)


            }
            .catch { error in

                print("getting the 5 day Data:/(error.localizedDescription)")
            }
//            print(fiveDayForecastURL)
        }
        
        .catch { error in
            
            print("Error in getting city:\(error.localizedDescription)")
          }
        
    }
    
    func getLocationURL(_ lat:CLLocationDegrees,_ lng:CLLocationDegrees)->String{

        var url=locationURL
        url.append(apiKey)
        url.append("&q=\(lat),\(lng)")
        return url

    }
    
    func getFiveDayForecastURL(_ cityKey:String)->String{
        
        var url=fiveDayForecastURL
        url.append("\(cityKey)")
        url.append("?apikey=\(apiKey)")
        return url
        
    }
    
    func getcurrentConditionURL(_ cityKey:String)->String{
        
        var url = currentConditionURL
        url.append("\(cityKey)")
        url.append("?apikey=\(apiKey)")
        return url
        
        }
    func getLocationData(_ url:String)->Promise<(String,String)>{
        
        return Promise<(String,String)>{seal -> Void in
            
            AF.request(url).responseJSON{response in
                
                if response.error != nil{
                    
                    seal.reject(response.error!)
                    
                }
                
                let locationJSON :JSON = JSON(response.data as Any)
                
                let Key = locationJSON["Key"].stringValue
                let   city   = locationJSON["LocalizedName"].stringValue
                
                let oneDayURL = self.getcurrentConditionURL(Key)
                self.getCurrentConditionData(oneDayURL)
                
                print(oneDayURL)
                
                self.lblCity.text = city
                
                seal.fulfill( (Key,city) )
            }
        }
    }
    
    
    
    
    func updateFiveDayData(_ url:String)->Promise<[Forecast]>{

        return Promise<[Forecast]>{seal -> Void in

            AF.request(url).responseJSON{ [self]response in

                if response.error != nil{

                    seal.reject(response.error!)

                }


                let json:JSON = JSON(response.data)
                
               // print(json)

                let dailyForecasts:[JSON] = json["DailyForecasts"].arrayValue
                 
                self.forecastArray=[Forecast]()
            
                  for dateVal in dailyForecasts{

                    
                    
                    let date = dateVal["Date"].stringValue
                   let dateFormatter = DateFormatter()
                    
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ssZ"
                    let dte : Date? = dateFormatter.date(from: date)

                    let weekDays: String? = dte?.dayOfWeek()!

                  print(weekDays!)
                 print(dte!)
                    let maxIcon = dateVal["Day"]["Icon"].intValue
                    let minIcon = dateVal["Night"]["Icon"].intValue
                      //  self.ImgMax.image = UIImage(named: "\(maxIcon)-s")
                    let min = dateVal["Temperature"]["Minimum"]["Value"].intValue
                

                    let max = dateVal["Temperature"]["Maximum"]["Value"].intValue
                    
                    let Day = weekDays!
                    
                    let minImg : UIImage?  = UIImage(named: ("\(minIcon)-s"))
                    let maxImg : UIImage? = UIImage(named: ("\(maxIcon)-s"))
                    
                    
                    let forecast = Forecast(min: min,max: max,Day:Day,minIcon: minIcon,maxIcon: maxIcon,minIconImg: minImg ?? globalImage!,maxIconImg: maxImg ?? globalImage!)
                    forecast.min = min
                    forecast.max = max
                    forecast.Day = Day
                    forecast.minIcon = minIcon
                    forecast.maxIcon = maxIcon
                    forecast.minIconImg = minImg ?? globalImage!
                    forecast.maxIconImg = maxImg ?? globalImage!
            
                    self.forecastArray.append(forecast)
                    
                    
                    self.forecastTbl.reloadData()
                    
                }
                lblHigh.text = "H:\(self.forecastArray[0].max)°F"
                lblLow.text = "L:\(self.forecastArray[0].min)°F"
                self.maxIconImg.image = UIImage(named:"\(self.forecastArray[0].maxIcon)-s") 
                self.minIconImg.image = UIImage(named:"\(self.forecastArray[0].minIcon)-s")
                //print(weatherText)
                
               // print("hello")
                
                
                seal.fulfill( (self.forecastArray) )
            }


                }
    }
    
    func getCurrentConditionData(_ url:String)->Promise<(Int)>{
        
        return Promise<(Int)>{seal -> Void in
            
            AF.request(url).responseJSON{response in
                
                if response.error != nil{
                    
                    seal.reject(response.error!)
                    
                }
                
                let currentJSON :JSON = JSON(response.data)
                
                
                
                let temp : [JSON] = currentJSON[].arrayValue
                
                
                    
                for temps in temp{
                    
                    let currentTemp = temps["Temperature"]["Imperial"]["Value"].intValue
                    
                    let weatherText = temps["WeatherText"]
                    self.lblWther.text = "\(weatherText)"
                    print(currentTemp )
                    
                    self.lblCurrentTemp.text = "\(currentTemp)°F"
                    
                    let weatherIcon = temps["WeatherIcon"].intValue
                    
                    print("\(weatherIcon) check")
                    
                    self.WeatherIconImg.image = UIImage(named:"\(weatherIcon)-s")
                    
                    
                }
                
               

                seal.fulfill( (1) )
            }
        }
    }
}
extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        
    }
}
