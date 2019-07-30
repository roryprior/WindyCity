//
//  FavouritesTableViewController.swift
//  Windy City
//
//  Created by Rory Prior on 29/07/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import UIKit

class FavouritesTableViewController: UITableViewController {

  private let favouritesManager = FavouritesManager.shared()
  private let reuseIdentifier = "FavouriteCell"
  
  private var addButton : UIBarButtonItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
 
    self.title = "Favourite Cities"
    self.tableView.rowHeight = 80
    self.tableView.register(UINib.init(nibName: "FavouriteTableViewCell", bundle: .main), forCellReuseIdentifier: reuseIdentifier)
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem
    
    addButton = UIBarButtonItem.init(title: "Add City", style: .plain, target: self, action: #selector(addCity(sender:)))
  
    self.toolbarItems = [UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                         addButton!,
                         UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)]
  }

  override func viewWillAppear(_ animated: Bool) {
    
    self.navigationController?.setToolbarHidden(false, animated: true)
    self.tableView.reloadData()
  }
  
  // MARK: - Actions
  
  @objc func addCity(sender: Any?) {
    
    let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
    let viewController = storyboard.instantiateViewController(withIdentifier: "AddCity") as! CitySearchViewController
    self.navigationController?.pushViewController(viewController, animated: true)
  }
  
  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favouritesManager.count()
  }


  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FavouriteTableViewCell
    
    let favourite = favouritesManager.itemAt(indexPath.row)
    cell.viewModel = FavouriteViewModel.init(favourite: favourite)
    
    return cell
  }
  
  
  // Override to support editing the table view.
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      
      self.favouritesManager.removeItemAt(indexPath.row)
      self.favouritesManager.save()
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }

  // Override to support rearranging the table view.
  override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    self.favouritesManager.swapAt(indexA: fromIndexPath.row, indexB: to.row)
    self.favouritesManager.save()
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let favourite = favouritesManager.itemAt(indexPath.row)
    if let forecast = favourite.forecast {
      favouritesManager.selectedFavourite = indexPath.row
      let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
      let viewController = storyboard.instantiateViewController(withIdentifier: "Forecast") as! ForecastTableViewController
      viewController.forecastViewModel = ForecastViewModel.init(forecast: forecast)
      self.navigationController?.pushViewController(viewController, animated: true)
    }
  }
}
