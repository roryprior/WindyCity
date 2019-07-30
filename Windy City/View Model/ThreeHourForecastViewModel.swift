//
//  ThreeHourForecastViewModel.swift
//  Windy City
//
//  Created by Rory Prior on 29/07/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import UIKit

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
    return threeHourForecast.weather[0].description
  }
  
  /**
   * Wind speed in meters per second
   */
  func windSpeed() -> String {
    return String(format: "%.1f m/s", threeHourForecast.wind.speed)
  }
  
  /**
   * Returns combined info about wind speed and general direction
   */
  func windDescription() -> String {
    return "Wind: \(windSpeed()), \(windDirection())"
  }
  
  func windDirectionDegrees() -> Double {
    return threeHourForecast.wind.deg
  }
  
  /**
   * Converts wind direction in degrees into cardinal or intercardinal directions
   * (N, NE, E, SE, S, SW, W, NW)
   */
  func windDirection() -> String {
    
    let degrees = Int(round(threeHourForecast.wind.deg))
    
    // cardinal directions with fuzzy match to within +/- 5 degrees
    if (0...5).contains(degrees) || (355...359).contains(degrees) { return "N" }
    if (85...95).contains(degrees) { return "E" }
    if (175...185).contains(degrees) { return "S" }
    if (265...275).contains(degrees) { return "W" }
    
    // Intercardinal directions
    var directionString = ""
    if degrees > 270 || degrees < 90 { directionString = "N" }
    else { directionString = "S" }
    if(degrees > 0 && degrees < 180) { directionString.append("E") }
    if(degrees > 180 && degrees <= 359) { directionString.append("W") }
    
    return directionString
  }
  
  func weatherIcon() -> UIImage? {
    
    return UIImage.init(named: threeHourForecast.weather[0].icon)
  }
  
  func timeOfDay() -> String {
    
    let date = Date.init(timeIntervalSince1970: threeHourForecast.dt)
    let formatter = DateFormatter()
    formatter.locale = Locale.init(identifier: "en_GB")
    formatter.setLocalizedDateFormatFromTemplate("HH:mm")
    
    return formatter.string(from: date)
  }
  
  func dayOfMonth() -> String {
    
    let calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
    let date = Date.init(timeIntervalSince1970: threeHourForecast.dt)
    
    return String(format: "%d", calendar.dateComponents([.day], from: date).day ?? 0)
  }
  
  func monthName() -> String {
    
    let date = Date.init(timeIntervalSince1970: threeHourForecast.dt)
    let formatter = DateFormatter()
    formatter.locale = Locale.init(identifier: "en_GB")
    formatter.setLocalizedDateFormatFromTemplate("MMM")
    
    return formatter.string(from: date)
  }
}
