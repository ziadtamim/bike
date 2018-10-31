//
//  BikeServiceTests.swift
//  CobiBikeTests
//
//  Created by Ziad on 10/31/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import Foundation
import XCTest
import Alamofire
@testable import CobiBike

class BikeServiceTests: XCTestCase {
    var subject: BikeService!
    var httpClient: FakeHTTPClient!
    
    override func setUp() {
        super.setUp()
        httpClient = FakeHTTPClient()
        subject = BikeService(httpClient: httpClient)
    }
    
    func testBikeList_httpFailure() {
        var bikeListResult: Result<[Bike]>?
        let expect = expectation(description: "Bike list completed")
        
        let httpRequest = HTTPRequest(url: URL(string: "bikes", relativeTo: URL(string: Config.baseURL)!)!)
        httpClient.send_stubbed[httpRequest] = .failure(HTTPError.emptyResponse)
        subject.get(location: Location(lat: 0, long: 0)) { result in
            bikeListResult = result
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssertTrue(bikeListResult!.isFailure)
    }
    
    func testBikeList_httpSuccessDeserializerFailure() {
        var bikeListResult: Result<[Bike]>?
        let expect = expectation(description: "Bike list completed")
        
        let httpRequest = HTTPRequest(url: URL(string: "bikes", relativeTo: URL(string: Config.baseURL)!)!)
        httpClient.send_stubbed[httpRequest] = .success(Fixtures.data(forJson: "invalid-bike-list-response"))
        subject.get(location: Location(lat: 0, long: 0)) { result in
            bikeListResult = result
            expect.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
        XCTAssertTrue(bikeListResult!.isFailure)
    }

    func testCurrentFix_httpSuccessDeserializerSuccess() {
        var bikeListResult: Result<[Bike]>?
        let expect = expectation(description: "Bike list completed")
        
        let httpRequest = HTTPRequest(url: URL(string: "bikes", relativeTo: URL(string: Config.baseURL)!)!)
        httpClient.send_stubbed[httpRequest] = .success(Fixtures.data(forJson: "valid-bike-list-response"))
        subject.get(location: Location(lat: 0, long: 0)) { result in
            bikeListResult = result
            expect.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
        let expected = Result.success(Fixtures.validBikeList())
        XCTAssertEqual(bikeListResult!, expected)
    }
}
