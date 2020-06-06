//
//  AirportStations.swift
//  FlightSearch
//
//  Created by MAC on 06/06/2020.
//  Copyright © 2020 EduardoJordan.com. All rights reserved.
//

import Foundation

struct AirportStations : Codable {
    
    let stations : [Stations]
}

struct Stations: Codable {
    
    let code: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case code
        case name
    }
    
    init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(String.self, forKey: .code)
        name = try container.decode(String.self, forKey: .name)
        
    }
}
