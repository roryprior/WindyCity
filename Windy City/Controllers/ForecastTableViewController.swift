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
  
  var forecastViewModel : ForecastViewModel? {
    didSet {
      if forecastViewModel != nil {
        self.title = forecastViewModel!.cityName()
      }
      self.tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.register(UINib.init(nibName: "ForecastTableViewCell", bundle: .main), forCellReuseIdentifier: forecastCellIdentifier)
    self.tableView.rowHeight = 115
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.navigationController?.setToolbarHidden(false, animated: true)
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
