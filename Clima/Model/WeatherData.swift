//
//  WeatherData.swift
//  Clima
//
//  Created by Project X on 2/14/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData:Decodable{
    let name:String
    let main:Main // struct
    let weather: [Weather]
}
struct Weather: Decodable{
    let description: String
    let id: Int // an ID describing the weather type in openWeather.com
}

struct Main:Decodable{
    let temp:Double
}
