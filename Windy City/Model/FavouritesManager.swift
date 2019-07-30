//
//  FavouritesManager.swift
//  Windy City
//
//  Created by Rory Prior on 29/07/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import Foundation

class FavouritesManager {
  
  private var favorites : Array<Favorite>
  
  private class func filePath() -> String {
    
    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    return "\(documentDirectory)/favorites.json"
  }
  
  init() {
    
    self.favorites = Array.init()
    
    if FileManager.default.fileExists(atPath: FavouritesManager.filePath()) {
      
      do {
        let decoder = JSONDecoder()
        if let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: FavouritesManager.filePath())) {
          self.favorites = try decoder.decode(Array<Favorite>.self, from: data)
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
  
  func swapAt(indexA: Int, indexB : Int) {
    self.favorites.swapAt(indexA, indexB)
    self.save()
  }
  
  func itemAt(_ index: Int) -> Favorite {
    return self.favorites[index]
  }
  
  func count() -> Int {
    return self.favorites.count
  }
  
  func add(_ item : Favorite) {
    self.favorites.append(item)
    self.save()
  }
  
  func removeItemAt(_ index: Int) {
    self.favorites.remove(at: index)
    self.save()
  }
  
  private func save() {
    do {
      let encoder = JSONEncoder()
      if let encoded = try? encoder.encode(self.favorites) {
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