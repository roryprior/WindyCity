//
//  Forecast.swift
//  Windy City
//
//  Created by Rory Prior on 29/07/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import Foundation

struct Forecast : Codable {
  
  struct City : Codable {
    var id: String
    var name: String
  }
  
  struct Main : Codable {
    var temp : Double
    var humidty: Int
    var pressure: Double
  }
  
  struct Weather : Codable {
    var id: String
    var main: String
    var description : String
    var icon : String
  }
  
  struct Wind : Codable {
    var speed : Double
    var deg : Double
  }
  
  struct Hourly : Codable {
    var dt: String
    var main: Main
    var weather : Array<Weather>
    var wind : Wind
  }

  var city : City
  var list : Array<Hourly>
}
