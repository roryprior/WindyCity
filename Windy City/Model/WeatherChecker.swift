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
  
  
  func fetchForecast(city: String, completion: @escaping (_ forecast : Forecast?, _ error: Error?) -> Void) {
    
    let forecastEndPoint = URL(string: "https://api.openweathermap.org/data/2.5/forecast")
    let forecastParams = [
      "q": city,
      "appid": appID,
      "units": "metric",
    ]
    
    super.sendRequest(URL: forecastEndPoint, params: forecastParams, method: "GET") { (data, error) in
      
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
