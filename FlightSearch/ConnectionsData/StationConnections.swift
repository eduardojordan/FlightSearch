//
//  Network.swift
//  FlightSearch
//
//  Created by MAC on 06/06/2020.
//  Copyright © 2020 EduardoJordan.com. All rights reserved.
//

import UIKit
import Foundation


enum Type:String {
    case GET
//    case POST

}


class StationConnections {
    
    private var airportStations: AirportStations?
    
    func callStationsList(completion: @escaping(AirportStations) -> ()){
        
        let urlAirports = "https://tripstest.ryanair.com/static/stations.json"
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: urlAirports)!)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil, let  response = response as? HTTPURLResponse
                else{
                    print("An error has occurred")
                    return
            }
            if response.statusCode == 200{
                do {
                    let decoder = JSONDecoder()
                    self.airportStations = try decoder.decode(AirportStations.self, from: data)
                    completion(self.airportStations!)
                } catch  {
                    print("Error. \(error)")
                }
            }else{
                print("Error in Server \(response.statusCode)")
            }
        }.resume()
    }
}
