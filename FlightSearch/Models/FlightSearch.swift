////////
////////  FlightSearch.swift
////////  FlightSearch
////////
////////  Created by MAC on 07/06/2020.
////////  Copyright © 2020 EduardoJordan.com. All rights reserved.
////////
//////




import Foundation
import UIKit

//struct Fare: Codable {
//
//    var publishedFare: Double?
//
//}
//
//class MainFare: Codable {
//    var fareKey: String?
//    var fareClass: String?
//    var fares: [Fare]
//}
//
//class RegularFare: MainFare {
//
//
//    var flightNumber: String?
//
//}
//
//struct Flight: Codable {
//    var time : [String]?
//    var timeDate : [Date]? {
//        get {
//            var items = [Date]()
//            if time != nil {
//                for item in time! {
//                    items.append(item.shortISO8601!)
//                }
//            }
//            return items
//        }
//    }
//    var regularFare: RegularFare?
//
//}
//struct FlightDate: Codable {
//    var dateOut: String?
//    var dateOutDate: Date? {
//        get { return dateOut?.shortISO8601 }
//    }
//    var flights: [Flight]?
//}
//
//struct Trip: Codable {
//    var dates: [FlightDate]?
//}
//
//struct FlightResponse: Codable {
//    var trips: [Trip]?
//
//}

struct FlightSearch : Codable {
    let trips: [Trips]?


}

struct Trips : Codable {
    let dates: [Dates]?
}

struct Dates : Codable{
    let dateOut: String?
    let flights: [Flights]?
}

struct Flights: Codable{
    let regularFare: RegularFare?
    let flightNumber: String?
}

struct RegularFare: Codable{
    let fares: [Fares]?
}

struct Fares: Codable{
    let publishedFare: Double?
}

extension Dates {
    enum CodingKeys: String, CodingKey {
        case dateOut, flights
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        dateOut = try container.decode(String.self, forKey: .dateOut)
//        print("dateOut DESDE MODEL", dateOut)
        flights = try container.decode([Flights].self, forKey: .flights)
        //        print("flights DESDE MODEL", flights)

    }
}

extension Flights {
    enum FlightsCodingKeys: String, CodingKey {
        case flightNumber, regularFare
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FlightsCodingKeys.self)
        flightNumber = try container.decode(String.self, forKey: .flightNumber)
//        print("flightNumber DESDE MODEL", flightNumber)
        regularFare = try container.decode(RegularFare.self, forKey: .regularFare)
    }
}

extension Fares {
    enum FaresCodingKeys: String, CodingKey {
        case publishedFare
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FaresCodingKeys.self)
        publishedFare = try container.decode(Double.self, forKey: .publishedFare)
//        print("publishedFare DESDE MODEL", publishedFare)
    }
}


//VA
//struct FlightSearch2: Codable {
//    let trips: [Trips]
//
//}
//
//struct Trips: Codable {
//    let dates: [Dates]
//}
//
//struct Dates: Codable {
//    let dateOut: String
//    let flights: [Flights]
//}
//
//struct Flights: Codable {
//    let regularFare: RegularFare
//    let flightNumber: String
//}
//
//struct RegularFare: Codable {
//    let fares: [Fares]
//}
//
//struct Fares: Codable {
//    let publishedFare: Double
//}
//

