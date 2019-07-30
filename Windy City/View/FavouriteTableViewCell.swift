//
//  FavouriteTableViewCell.swift
//  Windy City
//
//  Created by Rory Prior on 30/07/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

  @IBOutlet var cityLabel : UILabel!
  @IBOutlet var forecastDateLabel : UILabel!
  @IBOutlet var weatherIconImageView : UIImageView!
  @IBOutlet var compassView : CompassView!
  
  var viewModel : FavouriteViewModel? {
    didSet {
      updateUI()
    }
  }
  
  func updateUI() {
    cityLabel.text = viewModel?.cityName()
    forecastDateLabel.text = viewModel?.forecastDateTime()
    weatherIconImageView.image = viewModel?.weatherIcon()
    compassView.degrees = viewModel?.windDirectionDegrees() ?? -1
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    updateUI()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
    
}
