//
//  ViewController.swift
//  AppWeatherDN
//
//  Created by iOS Akademija on 1/19/18.
//  Copyright © 2018 iOS Akademija. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    
   // Outlets
    
    @IBOutlet private weak var cityName: UILabel!
    @IBOutlet private weak var temperature: UILabel!
    
    @IBOutlet private weak var searchBar: UISearchBar!
    
    // DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
         let urlRequest = URLRequest(url: URL(string: "https://api.apixu.com/v1/current.json?key=bd216786175b4cc0ac4121919173012&q=\(searchBar.text!.replacingOccurrences(of: " ", with: "%20"))")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        
            if error == nil {
                do {
                    let object = try JSONDecoder().decode(Object.self, from: data!)
               
                    DispatchQueue.main.async {
                        self.cityName.text =  "\(object.location.name)"
                        self.temperature.text = "\(object.current.temp_c)"
                    }
                
                } catch {
                    print(error)
                }
            }
     
        
        
        }
        task.resume()
    }

}














