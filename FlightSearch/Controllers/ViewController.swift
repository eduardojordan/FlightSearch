//
//  ViewController.swift
//  FlightSearch
//
//  Created by MAC on 06/06/2020.
//  Copyright © 2020 EduardoJordan.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let airportStations = StationConnections()
    var stationArray = [AirportStations]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         callAirportStationList()
        
    }
    
    func callAirportStationList(){
        airportStations.callStationsList { airportStations in
            print("Tenemos STATIONS \(airportStations.stations)")
        }
        
    }
    
    
}

