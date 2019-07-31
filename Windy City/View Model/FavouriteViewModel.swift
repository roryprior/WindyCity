//
//  FavouriteViewModel.swift
//  Windy City
//
//  Created by Rory Prior on 30/07/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import UIKit

class FavouriteViewModel {
  
  var favourite : Favourite
  
  init(favourite: Favourite) {
    self.favourite = favourite
  }
  
  func cityName() -> String {
    return favourite.cityName
  }
  
  private func mostCurrentForecast() -> Forecast.ThreeHourForecast? {
    
    guard favourite.forecast != nil else { return nil }
    guard favourite.forecast!.list != nil else { return nil }
    
    let now = Date.init()
    
    for threeHourforecast in favourite.forecast!.list! {
      let forecastDate = Date.init(timeIntervalSince1970: threeHourforecast.dt)
      if forecastDate > now {
        return threeHourforecast
      }
    }
    
    return favourite.forecast!.list!.last
  }
  
  func forecastDateTime() -> String {
    
    if let threeHourForecast = self.mostCurrentForecast() {
      
      let date = Date.init(timeIntervalSince1970: threeHourForecast.dt)
      let formatter = DateFormatter()
      formatter.locale = Locale.init(identifier: "en_GB")
      formatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy, HH:mm")
      return "Forecast: \(formatter.string(from: date))"
    }
    else {
      return "No forecast information"
    }
  }
  
  func windDirectionDegrees() -> Double {
    
    if let threeHourForecast = self.mostCurrentForecast() {
      return ThreeHourForecastViewModel.init(threeHourForecast: threeHourForecast).windDirectionDegrees()
    }
    else {
      return -1
    }
  }
  
  func weatherIcon() -> UIImage? {
    
    if let threeHourForecast = self.mostCurrentForecast() {
      return ThreeHourForecastViewModel.init(threeHourForecast: threeHourForecast).weatherIcon()
    }
    else {
      return nil
    }
  }
}
