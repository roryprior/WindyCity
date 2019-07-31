//
//  CitySearchViewController.swift
//  Windy City
//
//  Created by Rory Prior on 29/07/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import UIKit

class CitySearchViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet var textField : UITextField!
  
  // MARK: - View Lifecycle
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    self.title = "City Search"
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    self.navigationController?.setToolbarHidden(true, animated: true)
    self.textField.becomeFirstResponder()
    self.textField.selectAll(nil)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    
    super.viewWillDisappear(animated)
    self.textField.resignFirstResponder()
  }
  
  // MARK: - UITextField Delegate
    
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    textField.resignFirstResponder()
  
    if let text = textField.text {
      
      // lets avoid searching for a city with a name of 3 characters or less
      guard text.count > 3 else {
        return false
      }
      
      // make the API call...
      let weatherChecker = WeatherChecker.init()
      weatherChecker.fetchForecast(city: text) { (forecast, error) in
        
        DispatchQueue.main.async { [weak self] in
        
          if error != nil {
            
            let alertController = UIAlertController.init(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
            alertController.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
            self?.present(alertController, animated: true, completion: nil)
          }
          if(forecast != nil) {
            
            // add the city as a favourite
            
            if forecast?.city != nil {
              let favouriteManager = FavouritesManager.shared()
              let result = favouriteManager.add(Favourite.init(cityName: forecast!.city!.name, cityID: forecast!.city!.id, forecast: forecast))
              
              if result == false {
                
                let alertController = UIAlertController.init(title: "Can't Add Favourite", message: "Maximum number of favourite cities have been added.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
                self?.present(alertController, animated: true, completion: nil)
                return
              }
            }
              
            // present the city forecast
            let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Forecast") as! ForecastTableViewController
            viewController.forecastViewModel = ForecastViewModel.init(forecast: forecast!)
            self?.navigationController?.pushViewController(viewController, animated: true)
          }
        }
      }
    }
    return true
  }
}
