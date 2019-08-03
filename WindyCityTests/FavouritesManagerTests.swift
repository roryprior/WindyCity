//
//  FavouritesManagerTests.swift
//  Windy CityTests
//
//  Created by Rory Prior on 03/08/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import XCTest

class FavouritesManagerTests: XCTestCase {

  var favouritesManager : FavouritesManager?
  let testItemA = Favourite.init(cityName: "Leeds",
                                cityID: 12345,
                                forecast: Forecast.init(city: Forecast.City.init(id: 12456, name: "Leeds"),
                                                        list: Array.init() as Array<Forecast.ThreeHourForecast>))
  let testItemB = Favourite.init(cityName: "Manchester",
                                cityID: 67890,
                                forecast: Forecast.init(city: Forecast.City.init(id: 67890, name: "Manchester"),
                                                        list: Array.init() as Array<Forecast.ThreeHourForecast>))
  
  override func setUp() {
    // remove any saved data that could influence tests...
    do {
      try FileManager.default.removeItem(atPath: FavouritesManager.filePath())
    }
    catch let error {
      print(error)
    }
  }

  override func tearDown() {
    favouritesManager = nil
  }
  
  func testAdding() {
    // given
    favouritesManager = FavouritesManager.init()
    
    // where
    let addSuccess = favouritesManager?.add(testItemA)
    
    // then
    XCTAssertTrue(addSuccess!)
    XCTAssert(favouritesManager!.count() == 1)
  }
  
  func testAddingPastLimit() {
    // given
    favouritesManager = FavouritesManager.init()
    
    var success = false
    
    // where
    let exceedFavouriteLimit = favouritesManager!.favouriteLimit + 1
    
    for _ in (1...exceedFavouriteLimit) {
      success = favouritesManager!.add(testItemA)
    }
    
    // then
    XCTAssertTrue(success == false)
    XCTAssert(favouritesManager!.count() == favouritesManager!.favouriteLimit)
  }
  
  func testSwapping() {
    // given
    favouritesManager = FavouritesManager.init()
    let addSuccessA = favouritesManager!.add(testItemA)
    let addSuccessB = favouritesManager!.add(testItemB)
    
    // where
    favouritesManager!.swapAt(indexA: 0, indexB: 1)
    
    // then
    XCTAssert(addSuccessA)
    XCTAssert(addSuccessB)
    XCTAssert(favouritesManager!.count() == 2)
    XCTAssert(favouritesManager!.itemAt(0).cityName == testItemB.cityName)
    XCTAssert(favouritesManager!.itemAt(1).cityName == testItemA.cityName)
  }
  
  func testItemAt() {
    // given
    favouritesManager = FavouritesManager.init()
    
    // where
    let addSuccessA = favouritesManager!.add(testItemA)
    let addSuccessB = favouritesManager!.add(testItemB)
    
    // then
    XCTAssert(addSuccessA)
    XCTAssert(addSuccessB)
    XCTAssert(favouritesManager?.itemAt(0).cityName == testItemA.cityName)
    XCTAssert(favouritesManager?.itemAt(1).cityName == testItemB.cityName)
  }
  
  func testRemoving() {
    // given
    favouritesManager = FavouritesManager.init()
    let addSuccess = favouritesManager!.add(testItemA)
    
    // where
    favouritesManager!.removeItemAt(0)
    
    // then
    XCTAssert(addSuccess)
    XCTAssert(favouritesManager?.count() == 0)
  }

  func testSave() {
    // given
    favouritesManager = FavouritesManager.init()
    
    // where
    favouritesManager!.save()
    
    // then
    XCTAssertTrue(FileManager.default.fileExists(atPath: FavouritesManager.filePath()))
  }
  
  func testLoad() {
    
    // given
    favouritesManager = FavouritesManager.init()
    let addSuccessA = favouritesManager!.add(testItemA)
    let addSuccessB = favouritesManager!.add(testItemB)
    favouritesManager!.save()
    favouritesManager = nil
    
    // where
    favouritesManager = FavouritesManager.init()
    favouritesManager!.load()
    
    // then
    XCTAssertTrue(addSuccessA)
    XCTAssertTrue(addSuccessB)
    XCTAssertTrue(FileManager.default.fileExists(atPath: FavouritesManager.filePath()))
    XCTAssert(favouritesManager!.count() == 2)
    XCTAssert(favouritesManager!.itemAt(0).cityName == testItemA.cityName)
    XCTAssert(favouritesManager!.itemAt(1).cityName == testItemB.cityName)
  }
}
