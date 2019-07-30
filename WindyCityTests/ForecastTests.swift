//
//  ForecastTests.swift
//  Windy CityTests
//
//  Created by Rory Prior on 30/07/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import XCTest

class ForecastTests: XCTestCase {

  var forecast : Forecast?
  var error : Error?
  
  /**
   * Load a known good sample of data returned from the 2.5 OpenWeather API response
   * to endpoint api.openweathermap.org/data/2.5/forecast with city = "Leeds, UK",
   * a valid API key supplied and units set to "metric"
   */
  override func setUp() {
    // attempt to decode the response we got with the JSON decoder
    let decoder = JSONDecoder.init()
    
    do {
      let data = try Data.init(contentsOf: Bundle.main.url(forResource: "ForecastSample", withExtension: "json")!)
      
      do {
        self.forecast = try decoder.decode(Forecast.self, from: data)
      }
      catch let decodeError {
        self.error = decodeError
        return
      }
    }
    catch let dataError {
      self.error = dataError
      return
    }
  }

  override func tearDown() {
    self.forecast = nil
    self.error = nil
  }

  func testJSONLoaded() {
    XCTAssertNotNil(self.forecast)
    XCTAssertNil(self.error)
  }
  
  func testCityName() {
    XCTAssertEqual(self.forecast?.city?.name, "Leeds")
  }
  
  func testThreeHourForecastsPresent() {
    XCTAssertNotNil(self.forecast!.list)
  }
  
  func testThreeHourForecastDataSanity() {
    
    let distantPast = Date.distantPast.timeIntervalSince1970
    let distantFuture = Date.distantFuture.timeIntervalSince1970
    
    for threeHourForecast in self.forecast!.list! {
      
      XCTAssertTrue(threeHourForecast.dt > distantPast && threeHourForecast.dt < distantFuture) // unix time valid (this could be sanity checked better given more time to work on tests)
      XCTAssertTrue((-20...40).contains(threeHourForecast.main.temp)) // temp in celcius between -20 and +40 which should cover the extremes in Leeds!
      XCTAssertTrue((0...100).contains(threeHourForecast.main.humidity)) // humidty is expressed as percentage between 0 and 100%
      XCTAssertNotNil(threeHourForecast.weather[0]) // there should be at least 1 weather struct
      XCTAssertTrue(threeHourForecast.weather[0].description.count > 0) // weather description should contain more than 0 chars
      XCTAssertEqual(threeHourForecast.weather[0].icon.count, 3) // icon codes should be 3 characters
      XCTAssertTrue((0...359).contains(threeHourForecast.wind.deg)) // wind direction in degrees should be in range 0 to 359
      XCTAssertTrue(threeHourForecast.wind.speed >= 0) // wind speed will be 0 or greater m/s
    }
  }
}
