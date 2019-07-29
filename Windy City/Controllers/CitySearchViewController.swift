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
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.title = "City Search"
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    self.navigationController?.setToolbarHidden(true, animated: true)
    self.textField.becomeFirstResponder()
    self.textField.selectAll(nil)
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
            
            // present the city forecast
            print("looks good!")
          }
        }
      }
    }
    return true
  }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
