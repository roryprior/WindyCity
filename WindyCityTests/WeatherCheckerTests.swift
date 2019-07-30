//
//  ForecastTests.swift
//  Windy City Tests
//
//  Created by Rory Prior on 30/07/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import XCTest

class WeatherCheckerTests: XCTestCase {

  var forecast : Forecast?

  override func setUp() {
    forecast = nil
  }
  
  override func tearDown() {
  }
  
  func testCityIDEndPoint() {
    
    // given
    let weatherChecker = WeatherChecker.init()
    let expectation = self.expectation(description: #function)
    var error : Error?
    
    // when
    weatherChecker.fetchForecast(cityID: 2644688) { (aForecast, anError) in
      self.forecast = aForecast
      error = anError
      expectation.fulfill()
    }
    
    // then
    waitForExpectations(timeout: 10)
    XCTAssertEqual(forecast?.city?.name, "Leeds")
    XCTAssertNil(error)
  }
  
  func testCityNameEndPoint() {
    
    // given
    let weatherChecker = WeatherChecker.init()
    let expectation = self.expectation(description: #function)
    var error : Error?
    
    // when
    weatherChecker.fetchForecast(city: "Leeds, UK") { (aForecast, anError) in
      self.forecast = aForecast
      error = anError
      expectation.fulfill()
    }
    
    // then
    waitForExpectations(timeout: 10)
    XCTAssertEqual(forecast?.city?.name, "Leeds")
    XCTAssertNil(error)
  }
}
