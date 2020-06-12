//
//  SearchResultsViewController.swift
//  FlightSearch
//
//  Created by MAC on 07/06/2020.
//  Copyright © 2020 EduardoJordan.com. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView!
    
    var origin = ""
    var destination = ""
    var date = ""
    var adults = ""
    var teen = ""
    var child = ""
    
    private let flightSearch = FlightSearchConnections()
    var flightSearchData = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callResultSearch()
        
        tableView.rowHeight = 100
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func callResultSearch(){
        flightSearch.callSearchList(origin: origin, destination: destination, date: date, adults: adults, teen: teen, child: child) { (flightSearch) in
            
            self.flightSearchData = flightSearch as! [[String : String]]
            
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flightSearchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCellResults
        
        let flightData = self.flightSearchData[indexPath.row]
        
        cell.dateLabel.text = flightData["dateOut"]
        cell.flyNumberLabel.text =  flightData["flightNumber"]
        cell.regularFareLabel.text = flightData["priceNumber"] 
        
        return cell
    }
    
    
}
