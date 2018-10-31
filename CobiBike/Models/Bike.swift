//
//  Bike.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import Foundation
import CoreLocation

struct Bike: Codable, Equatable {
    let id: String
    let name: String
    let color: String
    let pin: String
    let location: Location
    let rented: Bool
}

struct Location: Codable, Equatable {
    let latitude: Double
    let longitude: Double
}

extension Location {
    
    init(lat: CLLocationDegrees, long: CLLocationDegrees) {
        latitude = Double(lat)
        longitude = Double(long)
    }
}
