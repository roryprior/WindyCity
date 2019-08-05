//
//  ForecastViewModel.swift
//  Windy City
//
//  Created by Rory Prior on 29/07/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import Foundation

class ForecastViewModel {
  
  var forecast : Forecast
  
  init(forecast: Forecast) {
    self.forecast = forecast
  }
  
  func cityName() -> String {
    return forecast.city?.name ?? "Unknown"
  }
  
  func cityID() -> Int {
    return forecast.city?.id ?? -1
  }
  
  func threeHourForecasts() -> Array<ThreeHourForecastViewModel> {
    
    guard self.forecast.list != nil else { return Array.init() as Array<ThreeHourForecastViewModel> }
    
    var returnArray = Array.init() as Array<ThreeHourForecastViewModel>
    
    returnArray = self.forecast.list!.map({
      return ThreeHourForecastViewModel.init(threeHourForecast: $0)
    })

    print("\(returnArray)")
    
    return returnArray
  }
  
}
