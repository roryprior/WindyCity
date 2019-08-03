//
//  FavouritesManager.swift
//  Windy City
//
//  Created by Rory Prior on 29/07/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import Foundation

class FavouritesManager {
  
  private static let sharedInstance = FavouritesManager()
  
  let favouriteLimit = 20
  private var favourites : Array<Favourite>
  
  class func filePath() -> String {
    
    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    return "\(documentDirectory)/favourites.json"
  }
  
  var selectedFavourite = -1
  
  init() {
    self.favourites = Array.init()
    load()
  }
  
  class func shared() -> FavouritesManager {
    return sharedInstance
  }
  
  func swapAt(indexA: Int, indexB : Int) {
    self.favourites.swapAt(indexA, indexB)
    self.save()
  }
  
  func itemAt(_ index: Int) -> Favourite {
    return self.favourites[index]
  }
  
  func count() -> Int {
    return self.favourites.count
  }
  
  func update(forecast: Forecast, atIndex : Int) {
    self.favourites[atIndex].forecast = forecast
    self.save()
  }
  
  func add(_ item : Favourite) -> Bool {
    
    if self.favourites.count < favouriteLimit {
      self.favourites.append(item)
      self.save()
      return true
    }
    else {
      return false
    }
  }
  
  func removeItemAt(_ index: Int) {
    self.favourites.remove(at: index)
    self.save()
  }
  
  func load() {
    if FileManager.default.fileExists(atPath: FavouritesManager.filePath()) {
      
      do {
        let decoder = JSONDecoder()
        if let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: FavouritesManager.filePath())) {
          self.favourites = try decoder.decode(Array<Favourite>.self, from: data)
        }
        else {
          print("Unable to decode any saved favourites")
        }
      }
      catch let error {
        print("Error loading favourites: \(error.localizedDescription)")
      }
    }
  }
  
  func save() {
    do {
      let encoder = JSONEncoder()
      if let encoded = try? encoder.encode(self.favourites) {
        if let json = String(data: encoded, encoding: .utf8) {
          try json.write(toFile: FavouritesManager.filePath(), atomically: true, encoding: .utf8)
        }
      }
    }
    catch let error {
      print("Error saving favourites: \(error.localizedDescription)")
    }
  }
  
}
