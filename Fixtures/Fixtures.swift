//
//  Fixtures.swift
//  CobiBikeTests
//
//  Created by Ziad on 10/31/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import Foundation
@testable import CobiBike

class Fixtures {
    class func data(forJson name: String) -> Data {
        let bundle = Bundle(for: self)
        let url = bundle.url(forResource: name, withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    class func validBikeList() -> [Bike] {
        return [Bike(id: "0", name: "Henry", color: "00C8E6", pin: "1234", location: Location(lat: 50.119504, long: 8.638137), rented: false)]
    }
    
    class func validBike() -> Bike {
        return validBikeList().first!
    }
}
