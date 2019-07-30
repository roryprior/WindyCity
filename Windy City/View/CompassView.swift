//
//  CompassView.swift
//  Windy City
//
//  Created by Rory Prior on 30/07/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import UIKit
import PureLayout

class CompassView: UIView {

  private var backgroundImageView = UIImageView.init()
  private var arrowImageView = UIImageView.init()
  
  var degrees = 0.0 {
    didSet {
      
      // if a negative number of degrees is supplied we hide the arrow
      if degrees < 0 {
        arrowImageView.isHidden = true
      }
      else {
        arrowImageView.isHidden = false
      }
      
      let radians = CGFloat(degrees * (.pi / 180))
      arrowImageView.transform = CGAffineTransform(rotationAngle: radians)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  func setup() {
    
    self.addSubview(backgroundImageView)
    self.addSubview(arrowImageView)
    
    self.backgroundColor = .clear
    
    backgroundImageView.image = UIImage.init(named: "Compass")
    arrowImageView.image = UIImage.init(named: "Arrow")
    
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    arrowImageView.translatesAutoresizingMaskIntoConstraints = false
    
    backgroundImageView.autoPinEdgesToSuperviewEdges()
    arrowImageView.autoPinEdgesToSuperviewEdges()
  }
  

}
