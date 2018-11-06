//
//  ListEarthquakesTableViewController.swift
//  EarthQuakeAppScore
//
//  Created by Soan Saini on 6/11/18.
//  Copyright © 2018 Soan Saini. All rights reserved.
//

import UIKit

class ListEarthquakesTableViewController: UITableViewController, ViewModelStatusDelegate {
    
    func viewModelUpdated() {
        pullToRefresh.endRefreshing()
        self.tableView.reloadData()
    }
    
    func viewModelFaulted(error: Error) {
        pullToRefresh.endRefreshing()
        self.tableView.reloadData()
    }
    
    private let pullToRefresh = UIRefreshControl()
    
    private var viewModel : EarthQuakeListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = EarthQuakeListViewModel()
        refreshEarthQuakes(self)
        
        tableView.refreshControl = pullToRefresh
        pullToRefresh.addTarget(self, action: #selector(refreshEarthQuakes(_:)), for: .valueChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.setupDelegate(delegate: self)
    }
    
    @objc private func refreshEarthQuakes(_ sender: Any) {
        // Fetch Earth Quake Data
        pullToRefresh.beginRefreshing()
        viewModel.refreshEarthQuakes()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalEarthQuakes
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let earthViewModel : EarthQuakeViewModel = viewModel.earthQuakeAtIndex(index: indexPath.row)
        cell.textLabel?.text = earthViewModel.displayText
        cell.detailTextLabel?.text = earthViewModel.subtitleText
        cell.selectionStyle = .none
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectEarthQuake(index: indexPath.row)
        performSegue(withIdentifier: "showOnMap", sender: self)
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mapVc = segue.destination as? ViewController {
            if segue.identifier == "displayMap"{
                viewModel.deSelectEarthQuake()
            }
            mapVc.setupViewModel(viewModel: self.viewModel)
        }
    }
}
