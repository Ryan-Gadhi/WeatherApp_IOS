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
    var delegate:WeatherManagerDelegate? = nil
    
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
        let task = session.dataTask(with: url) { (data, urlResponse, error) in
            // anonymouse function
            if error != nil {
                print("error: \(String(describing: error))")
                return
            }
            
            if let safeData = data{
                let jsonData = self.parseJson(data: safeData)
                
            }
        }
        // sending the request
        task.resume()
    }
    func parseJson(data:Data){
        let myDecoder = JSONDecoder()
        do {
            let decodedData = try myDecoder.decode(WeatherData.self, from: data)
            
            let weatherId = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let cityName = decodedData.name
            let description = decodedData.weather[0].description
            
            let weatherModel = WeatherModel(id: weatherId, cityName: cityName, description: description, temp: temp)
            
            delegate?.weatherDidUpdate(weatherModel: weatherModel)
                            
            print("the tempreuter is : \(weatherModel.roundedTemp)")
            print("the description is: \(weatherModel.description)")
            print("the icon name is: \(weatherModel.iconName)")
            
        }catch{
            print("could not parse jason")
        }
        
    }
   
    
}


protocol WeatherManagerDelegate {
    func weatherDidUpdate(weatherModel:WeatherModel)
}
