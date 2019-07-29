//
//  ThreeHourForecastViewModel.swift
//  Windy City
//
//  Created by Rory Prior on 29/07/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import Foundation

class ThreeHourForecastViewModel {
  
  var threeHourForecast : Forecast.ThreeHourForecast
  
  init(threeHourForecast: Forecast.ThreeHourForecast) {
    self.threeHourForecast = threeHourForecast
  }
  
  /**
   * Average temperature for this period in degrees celcius
   */
  func temperature() -> String {

    return String(format: "%.1fºC", threeHourForecast.main.temp)
  }
  
  /**
   * Humidity expressed as a percentage
   */
  func humidty() -> String {

    return String(format: "%d%%", threeHourForecast.main.humidity)
  }
  
  /**
   * Short textual description of weather conditions
   */
  func weatherDescription() -> String {
    
    return threeHourForecast.weather.description
  }
  
  /**
   * Wind speed in meters per second
   */
  func windSpeed() -> String {
    
    return String(format: "%.1f m/s", threeHourForecast.wind.speed)
  }
  
  /**
   * Converts wind direction in degrees into cardinal or intercardinal directions
   * (N, NE, E, SE, S, SW, W, NW)
   */
  func windDirection() -> String {
    
    let degrees = Int(round(threeHourForecast.wind.deg))
    
    // cardinal directions
    if degrees == 0 { return "N" }
    if degrees == 90 { return "E" }
    if degrees == 180 { return "S" }
    if degrees == 270 { return "W" }
    
    // Intercardinal directions
    var directionString = ""
    if degrees > 270 || degrees < 90 { directionString = "N" }
    else { directionString = "S" }
    if(degrees > 0 && degrees < 180) { directionString.append("E") }
    if(degrees > 180 && degrees <= 359) { directionString.append("W") }
    
    return directionString
  }
}
