//
//  SearchAirporListViewController.swift
//  FlightSearch
//
//  Created by MAC on 06/06/2020.
//  Copyright © 2020 EduardoJordan.com. All rights reserved.
//

import UIKit

protocol SelectOriginDelegate: NSObjectProtocol {
    func selectStationOrigin(item: Stations)
}

protocol SelectDestinationDelegate: NSObjectProtocol {
    func selectStationDestination(item: Stations)
}

class SearchAirportListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    private let airportStations = StationConnections()
    var stationArray = [Stations]()
    var searchStation = [Stations]()
    var searching = false
    
    
    weak var delegate: SelectOriginDelegate?
    weak var delegate2: SelectDestinationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAirportStationList()
        
    }
    
    // MARK: - Functions
    
    func callAirportStationList(){
        airportStations.callStationsList { airportStations in
            self.stationArray = airportStations.stations
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
    }
    
}

// MARK: - TableView

extension SearchAirportListViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return self.searchStation.count
        } else {
            return self.stationArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        
        if searching {
            cell.textLabel?.text = self.searchStation[indexPath.row].name
            cell.detailTextLabel?.text = self.searchStation[indexPath.row].code
            return cell
        } else {
            cell.textLabel?.text = self.stationArray[indexPath.row].name
            cell.detailTextLabel?.text = self.stationArray[indexPath.row].code
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if searching{
            let select = self.searchStation[indexPath.row]
            delegate?.selectStationOrigin(item: select)
            delegate2?.selectStationDestination(item: select)
            self.dismiss(animated: true, completion: nil)
        }else{
            let select = self.stationArray[indexPath.row]
            delegate?.selectStationOrigin(item: select)
            delegate2?.selectStationDestination(item: select)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

// MARK: - Search

extension SearchAirportListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchStation = self.stationArray.filter({$0.name.lowercased().prefix(searchText.count) == searchText.lowercased() || $0.code.lowercased().prefix(searchText.count) == searchText.lowercased()})
        
        self.searching = true
        self.tableView.reloadData()
        
    }
}
