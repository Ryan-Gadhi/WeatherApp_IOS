//
//  WeatherManager.swift
//  Clima
//
//  Created by Project X on 2/13/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation


struct WeatherManager{
    let apiKey = "ca31819e90361ab177862340aaee52da"
    let unit = "metric"
    let partialURL = "https://api.openweathermap.org/data/2.5/weather?"
    var fullURL:String? = nil
    
    init() {
        self.fullURL = partialURL+"units="+unit+"&appid="+apiKey
    }
    
    
    mutating func fetchWeather(of city: String){
        if var url = fullURL {
            url += "&q=\(city)"
            //print("url: \(url)")
            performWebRequest(to: url) // actual networking
        }
        
    }
    
    func performWebRequest(to urlString: String){
        
        // creating the URL object
        
        let url = URL(string: urlString)!
        // creating the URL Session
        let session = URLSession(configuration: .default) // I don't get how .default works
        // creating the Task
        let task = session.dataTask(with: url, completionHandler: handler)
        // sending the request
        task.resume()
        
        
    }
    func handler(data:Data?, urlResponse:URLResponse?, error:Error?){
        if error != nil { // there is an error
            print("error:\(error)")
            return
        }
        
        if let safeData = data{
            let responeJson = String(data: safeData, encoding: .utf8)
            print(responeJson)
        }
    };
}


