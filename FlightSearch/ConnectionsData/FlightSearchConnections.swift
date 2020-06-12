//
//  FlightSearchConnections.swift
//  FlightSearch
//
//  Created by MAC on 07/06/2020.
//  Copyright © 2020 EduardoJordan.com. All rights reserved.
//

import Foundation
import UIKit


class FlightSearchConnections {
    
    private var flightSearch: FlightSearch?
    private var flightSearchArray = [FlightSearch]()
    
    func callSearchList(origin:String, destination:String, date:String, adults:String, teen:String, child:String, completion: @escaping(FlightSearch) -> ()){
        
               let urlFlightSearch2 = "https://sit-nativeapps.ryanair.com/api/v4/Availability?origin=\(origin)&destination=\(destination)&dateout=\(date)&datein=&flexdaysbeforeout=3&flexdaysout=3&flexdaysbeforein=3&flexdaysin=0&adt=\(adults)&teen=\(teen)&chd=\(child)&roundtrip=false&ToUs=AGREED"
        
        let urlFlightSearch = "https://sit-nativeapps.ryanair.com/api/v4/Availability?origin=DUB&destination=STN&dateout=2021-08-09&datein=&flexdaysbeforeout=3&flexdaysout=3&flexdaysbeforein=3&flexdaysin=0&adt=1&teen=0&chd=0&roundtrip=false&ToUs=AGREED"
        
        let session = URLSession.shared
        let urlStr = urlFlightSearch.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        var request = URLRequest(url: URL(string: urlStr!)!)
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
                    decoder.dateDecodingStrategy = .iso8601
                    self.flightSearch = try decoder.decode(FlightSearch.self, from: data)
                    
                    let dataResponse = try decoder.decode(FlightSearch.self, from: data)
                    print(">>",dataResponse.trips) 
                    
                    self.flightSearchArray.append(dataResponse)
                    print(">>",self.flightSearchArray.count)
                    completion(dataResponse)
                } catch  {
                    print("Error. \(error)")
                }
            }else{
                print("Error in Server \(response.statusCode)  ATENTTION ----> ACTIVATE JSON MOCKUP MODE WHEN API IS OUT OF SERVICE OR DOWN <----")
                //// RESPONSE OF MOCKUP JSON WHEN API IS OUT SERVICE SERVICE OR DOWN
                if let json = Bundle.main.path(forResource: "search_response", ofType: "json"), let data =  FileManager.default.contents(atPath: json) {
                    let decoder = JSONDecoder()
                    do {
                        let dataResponse = try decoder.decode(FlightSearch.self, from: data)
                       completion(dataResponse)
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
        }.resume()
    }
}
