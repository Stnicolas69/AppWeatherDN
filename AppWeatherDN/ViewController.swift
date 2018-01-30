//
//  ViewController.swift
//  AppWeatherDN
//
//  Created by iOS Akademija on 1/19/18.
//  Copyright © 2018 iOS Akademija. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate {

    
   // Outlets
    
    @IBOutlet private weak var cityName: UILabel!
    @IBOutlet private weak var temperature: UILabel!
    @IBOutlet private weak var humidity: UILabel!
    @IBOutlet private weak var pressure: UILabel!
    @IBOutlet private weak var windSpeed: UILabel!
    @IBOutlet private weak var icon: UILabel!
    
    @IBOutlet private weak var searchBar: UISearchBar!
    
    @IBOutlet private weak var refreshButton: UIButton!
    

    // Location manager
    
    var locationManager = CLLocationManager()
    var latitude: String = ""
    var longitude: String = ""
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.stopUpdatingLocation()
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            latitude = String(location.coordinate.latitude)
            longitude = String(location.coordinate.longitude)
            getLocation(myLocation: myLocationURL)
        }
    }
    // View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
 
    
    
    // Network call

  
    var myLocationURL: String {
        get {
            return "https://api.apixu.com/v1/current.json?key=bd216786175b4cc0ac4121919173012&q=\(latitude),\(longitude)"
        }
    }
    
    func getLocation(myLocation: String) {
        guard let urlReq = URL(string: myLocation) else {fatalError("url is not valid") }
       
        let task = URLSession.shared.dataTask(with: urlReq) { data, response, error in
            
            guard error == nil else { return }
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            if !(200..<300).contains(httpResponse.statusCode) { return }
            guard let data = data else { return }
            
            do {
                
                let decoder = JSONDecoder()
                let object = try decoder.decode(Object.self, from: data)
                
                DispatchQueue.main.async {
                    
                    self.cityName.text = "\(object.location.name)"
                    self.temperature.text = "\(object.current.temp_c)"
                    self.humidity.text = "\(object.current.humidity)"
                    self.pressure.text = "\(object.current.pressure_mb)"
                    self.windSpeed.text = "\(object.current.wind_kph)"
                }
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
    
    
    // Network call
        
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
         let urlRequest = URLRequest(url: URL(string: "https://api.apixu.com/v1/current.json?key=bd216786175b4cc0ac4121919173012&q=\(searchBar.text!.replacingOccurrences(of: " ", with: "%20"))")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        
            if error == nil {
                do {
                    let object = try JSONDecoder().decode(Object.self, from: data!)
               
                    DispatchQueue.main.async {
                        self.cityName.text =  "\(object.location.name)"
                        self.temperature.text = "\(object.current.temp_c)°"
                        self.humidity.text = "\(object.current.humidity)%"
                        self.pressure.text = "\(object.current.pressure_mb)mb"
                        self.windSpeed.text = "\(object.current.wind_kph)kmH"
                    }
                  
                
                } catch {
                    print(error)
                }
            }
        }
        
        
        task.resume()
    }

    @IBAction func refreshMyLocation(_ sender: UIButton) {
        searchBar.text = ""
        locationManager.stopUpdatingLocation()
        print("tu sam")
    }
}














