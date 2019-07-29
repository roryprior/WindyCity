//
//  Forecast.swift
//  Windy City
//
//  API docs:
//  https://openweathermap.org/forecast5#name5
//
//  Created by Rory Prior on 29/07/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import Foundation

struct Forecast : Codable {
  
  struct City : Codable {
    var id: Int
    var name: String
  }
  
  struct Main : Codable {
    var temp : Double
    var humidity: Int
    var pressure: Double
  }
  
  struct Weather : Codable {
    var id: Int
    var main: String
    var description : String
    var icon : String
  }
  
  struct Wind : Codable {
    var speed : Double
    var deg : Double
  }
  
  struct ThreeHourForecast : Codable {
    var dt: Int64
    var main: Main
    var weather : Array<Weather>
    var wind : Wind
  }

  var city : City?
  var list : Array<ThreeHourForecast>?
}
