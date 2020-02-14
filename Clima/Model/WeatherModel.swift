//
//  WeatherModel.swift
//  Clima
//
//  Created by Project X on 2/14/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation


struct WeatherModel {
    
    let id:Int
    let cityName:String
    let description:String
    let temp:Double
    
    var roundedTemp:String { return  String(format : String(self.temp), "%.1f") }
    
    var iconName:String { // this is a computer property
        switch self.id{
           case 300...321:
               return "cloud.drizzle"
           case 500...531:
               return "cloud.rain"
           case 600...622:
               return "cloud.snow"
           case 701...781:
               return "cloud.fog"
           case 800:
               return "sun.max"
           case 801...804:
               return "cloud.bolt"
           default:
               return "sun.min"
           }
           
       }
}
