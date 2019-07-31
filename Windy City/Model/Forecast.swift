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
    /** OpenWeatherMap city ID number */
    var id: Int
    /** English name of city */
    var name: String
  }
  
  struct Main : Codable {
    /** Temperature */
    var temp : Double
    /** Humidty as value between 0 and 100 */
    var humidity: Int
  }
  
  struct Weather : Codable {
    /** Predominant weather condition (e.g "Sunny") */
    var main: String
    /** More detailed weather condition */
    var description : String
    /** Three character icon code */
    var icon : String
  }
  
  struct Wind : Codable {
    /** Wind speed in m/s */
    var speed : Double
    /** Wind direction in degrees */
    var deg : Double
  }
  
  struct ThreeHourForecast : Codable {
    /** UTC time in seconds since 1970 (UNIX time) for the forecast */
    var dt: Double
    /** Struct containing temperature and humidty info */
    var main: Main
    /** Array with a single element that is a Weather struct with weather description and icon */
    var weather : Array<Weather>
    /** Struct containing wind speed and direction */
    var wind : Wind
  }

  /** struct containing city name and ID */
  var city : City?
  /** array of ThreeHourForecast structs with forecasted weather information */
  var list : Array<ThreeHourForecast>?
}
