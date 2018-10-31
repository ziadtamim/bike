//
//  BikeTests.swift
//  CobiBikeTests
//
//  Created by Ziad on 10/31/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import XCTest
@testable import CobiBike

class ItemTests: XCTestCase {
    var decoder: JSONDecoder!
    
    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func testInitJSON_validJSON() {
        let jsonData = Fixtures.data(forJson: "valid-bike")
        let expected = Fixtures.validBike()
        XCTAssertEqual(try decoder.decode(Bike.self, from: jsonData), expected)
    }
    
    func testInitJSON_missingKey() {
        let jsonData = Fixtures.data(forJson: "invalid-bike-missing-key")
        XCTAssertThrowsError(try decoder.decode(Bike.self, from: jsonData))
    }
    
    func testName() {
        let subject = Bike(id: "1", name: "Henry", color: "FFDD3", pin: "3333", location: Location(lat: 50.119504, long: 8.638137), rented: false)
        XCTAssertEqual(subject.name, "Henry")
    }
}
