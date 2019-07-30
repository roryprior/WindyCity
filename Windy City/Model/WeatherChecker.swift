//
//  WeatherChecker.swift
//  Windy City
//
//  Created by Rory Prior on 29/07/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import UIKit

class WeatherChecker: APIRequest {

  private let appID = "3e2161379fa2f3e61026dd8d38b18041" // account key for accessing the weather API
  private let units = "metric" // this could become a user facing preference
  
  /**
   * Fetch forecast for city where we have an OpenWeatherMap city ID to use
   */
  func fetchForecast(cityID: Int, completion: @escaping (_ forecast : Forecast?, _ error: Error?) -> Void) {
    
    if let forecastEndPoint = URL(string: "https://api.openweathermap.org/data/2.5/forecast") {
      let forecastParams = [
        "id": String(cityID),
        "appid": appID,
        "units": units,
      ]
      
      handleRequest(endPoint: forecastEndPoint, params: forecastParams, completion: completion)
    }
  }
  
  /**
   * Fetch forecast for city by using city name and optionally country e.g. "London, UK"
   */
  func fetchForecast(city: String, completion: @escaping (_ forecast : Forecast?, _ error: Error?) -> Void) {
    
    if let forecastEndPoint = URL(string: "https://api.openweathermap.org/data/2.5/forecast") {
      let forecastParams = [
        "q": city,
        "appid": appID,
        "units": units,
      ]
      
      handleRequest(endPoint: forecastEndPoint, params: forecastParams, completion: completion)
    }
  }
  
  private func handleRequest(endPoint: URL, params: Dictionary<String,String>, completion: @escaping (_ forecast : Forecast?, _ error: Error?) -> Void) {
    
    super.sendRequest(URL: endPoint, params: params, method: "GET") { (data, error) in
      
      // check we got some kind of data
      guard data != nil else {
        completion(nil, error)
        return
      }
      
      // attempt to decode the response we got with the JSON decoder
      let decoder = JSONDecoder.init()
      
      do {
        let forecast = try decoder.decode(Forecast.self, from: data!)
        completion(forecast, nil)
      }
      catch let decodeError {
        completion(nil, decodeError)
      }
    }
  }
}
