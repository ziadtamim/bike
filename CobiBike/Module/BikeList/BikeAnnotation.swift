//
//  BikeAnnotation.swift
//  CobiBike
//
//  Created by Ziad on 10/27/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import UIKit
import MapKit

class BikeAnnotation: NSObject, MKAnnotation {
    let bike: Bike
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    
    init(_ bike: Bike) {
        self.bike = bike
        
        self.title = bike.id
        self.subtitle = bike.name
        self.coordinate = CLLocationCoordinate2D(latitude: bike.location.latitude, longitude: bike.location.longitude)
    }
}
