//
//  ForecastTableViewController.swift
//  Windy City
//
//  Created by Rory Prior on 29/07/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import UIKit

class ForecastTableViewController: UITableViewController {

  private let forecastCellIdentifier = "forecastCellIdentifier"
  
  private var refreshButton : UIBarButtonItem?
  
  private var cityID = -1
  var forecastViewModel : ForecastViewModel? {
    didSet {
      if forecastViewModel != nil {
        self.title = forecastViewModel!.cityName()
        self.cityID = forecastViewModel!.cityID()
      }
      self.tableView.reloadData()
      self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.register(UINib.init(nibName: "ForecastTableViewCell", bundle: .main), forCellReuseIdentifier: forecastCellIdentifier)
    self.tableView.rowHeight = 115
    
    refreshButton = UIBarButtonItem.init(title: "Refresh Forecast", style: .plain, target: self, action: #selector(refreshForecast(sender:)))
    
    self.toolbarItems = [UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                         refreshButton!,
                         UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)]
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.navigationController?.setToolbarHidden(false, animated: true)
  }
  
  // MARK: - Actions
  
  @objc func refreshForecast(sender: Any?) {
    
    guard cityID >= 0 else { return }
    
    let weatherChecker = WeatherChecker.init()
    weatherChecker.fetchForecast(cityID: cityID) { (forecast, error) in
      
      DispatchQueue.main.async { [weak self] in
        
        if error != nil {
          
          let alertController = UIAlertController.init(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
          alertController.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
          self?.present(alertController, animated: true, completion: nil)
        }
        if(forecast != nil) {
          
          FavouritesManager.shared().update(forecast: forecast!, atIndex: FavouritesManager.shared().selectedFavourite)
          self?.forecastViewModel = ForecastViewModel.init(forecast: forecast!)
        }
      }
    }
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard forecastViewModel != nil else { return 0 }
    return forecastViewModel!.threeHourForecasts().count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: forecastCellIdentifier, for: indexPath) as! ForecastTableViewCell
    cell.viewModel = forecastViewModel!.threeHourForecasts()[indexPath.row]
    return cell
  }
}
