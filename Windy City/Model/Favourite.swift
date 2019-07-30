//
//  Favourite.swift
//  Windy City
//
//  Created by Rory Prior on 29/07/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import Foundation

struct Favourite : Codable {
  
  var cityName : String
  var cityID : Int
  var forecast : Forecast?

}
