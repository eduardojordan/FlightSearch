////////
////////  FlightSearch.swift
////////  FlightSearch
////////
////////  Created by MAC on 07/06/2020.
////////  Copyright © 2020 EduardoJordan.com. All rights reserved.
////////
//////


import Foundation


struct FlightSearch : Decodable {
    let trips: [Trips]
    
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
        flights = try container.decode([Flights].self, forKey: .flights)
    }
}

extension Flights {
    enum FlightsCodingKeys: String, CodingKey {
        case flightNumber, regularFare
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FlightsCodingKeys.self)
        flightNumber = try container.decode(String.self, forKey: .flightNumber)
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
    }
}


