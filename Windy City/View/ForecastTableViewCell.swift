//
//  ForecastTableViewCell.swift
//  Windy City
//
//  Created by Rory Prior on 29/07/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

  @IBOutlet var compassView : CompassView!
  @IBOutlet var dayLabel : UILabel!
  @IBOutlet var monthLabel : UILabel!
  @IBOutlet var descriptionLabel : UILabel!
  @IBOutlet var windLabel : UILabel!
  @IBOutlet var timeLabel : UILabel!
  @IBOutlet var iconImageView : UIImageView!
  @IBOutlet var tempLabel : UILabel!
  @IBOutlet var humidityLabel : UILabel!
  
  var viewModel : ThreeHourForecastViewModel? {
    didSet {
      updateUI()
    }
  }
  
  func updateUI() {
    
    guard viewModel != nil else { return }

    self.dayLabel.text = viewModel?.dayOfMonth()
    self.monthLabel.text = viewModel?.monthName()
    self.timeLabel.text = viewModel?.timeOfDay()
    self.tempLabel.text = viewModel?.temperature()
    self.humidityLabel.text = viewModel?.humidty()
    self.windLabel.text = viewModel?.windDescription()
    self.iconImageView.image = viewModel?.weatherIcon()
    self.descriptionLabel.text = viewModel?.weatherDescription()
    self.compassView.degrees = viewModel?.windDirectionDegrees() ?? 0.0
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
    
}
