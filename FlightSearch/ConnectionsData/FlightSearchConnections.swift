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
    private var flightSearchData = [[String: String]]()
    
    func callSearchList(origin:String, destination:String, date:String, adults:String, teen:String, child:String, completion: @escaping(Any) -> ()){
        
        let urlFlightSearch = "https://sit-nativeapps.ryanair.com/api/v4/Availability?origin=\(origin)&destination=\(destination)&dateout=\(date)&datein=&flexdaysbeforeout=3&flexdaysout=3&flexdaysbeforein=3&flexdaysin=0&adt=\(adults)&teen=\(teen)&chd=\(child)&roundtrip=false&ToUs=AGREED"
        
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
                    let jsonDecoder = JSONDecoder()
                    let dataResponse = try jsonDecoder.decode(FlightSearch.self, from: data)
                    let dateOut = dataResponse.trips[0].dates![0].dateOut!.prefix(10)
                    let flyNumber = dataResponse.trips[0].dates![0].flights![0].flightNumber!
                    let priceNumber = dataResponse.trips[0].dates![0].flights![0].regularFare?.fares![0].publishedFare!
                    

                    
                    for i in 0..<dateOut.count{
                        
                        var dictionary = [String:String]()
                        dictionary.updateValue(String(dateOut), forKey: "dateOut")
                        dictionary.updateValue(flyNumber, forKey: "flightNumber")
                        dictionary.updateValue("\(priceNumber!)", forKey: "priceNumber")
                        
                        self.flightSearchData.append(dictionary)
                    }
                    
                    completion(self.flightSearchData)
                } catch  {
                    print("Error. \(error)")
                }
            }else{
                print("Error in Server \(response.statusCode)  ATENTTION ----> ACTIVATE JSON MOCKUP MODE WHEN API IS OUT OF SERVICE OR DOWN <----")
                //// RESPONSE OF MOCKUP JSON WHEN API IS OUT SERVICE SERVICE OR DOWN
                if let json = Bundle.main.path(forResource: "search_response", ofType: "json"), let data =  FileManager.default.contents(atPath: json) {
                    let decoder = JSONDecoder()
                    do {
                        let jsonDecoder = JSONDecoder()
                        let dataResponse = try jsonDecoder.decode(FlightSearch.self, from: data)
                        let dateOut = dataResponse.trips[0].dates![0].dateOut!.prefix(10)
                        let flyNumber = dataResponse.trips[0].dates![0].flights![0].flightNumber!
                        let priceNumber = dataResponse.trips[0].dates![0].flights![0].regularFare?.fares![0].publishedFare!
                        
                        for i in 0..<dateOut.count{
                            
                            var dictionary = [String:String]()
                            dictionary.updateValue(String(dateOut), forKey: "dateOut")
                            dictionary.updateValue(flyNumber, forKey: "flightNumber")
                            dictionary.updateValue("\(priceNumber!)", forKey: "priceNumber")
                            
                            self.flightSearchData.append(dictionary)
                            
                        }
                        completion(self.flightSearchData)
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
        }.resume()
    }
}

