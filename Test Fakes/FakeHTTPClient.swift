//
//  FakeHTTPClient.swift
//  CobiBikeTests
//
//  Created by Ziad on 10/31/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import Foundation
import Alamofire
@testable import CobiBike

class FakeHTTPClient: HTTPClientContract {
    
    var send_wasCalled = false
    var send_wasCalled_withRequest = [HTTPRequest]()
    var send_stubbed = [HTTPRequest: Result<Data>]()
    func send(request: HTTPRequest, completion: @escaping (Result<Data>) -> Void) {
        send_wasCalled = true
        send_wasCalled_withRequest.append(request)
        completion(send_stubbed[request]!)
    }
    
    func send_wasCalled_with(request: HTTPRequest) -> Bool {
        return send_wasCalled_withRequest.contains(request)
    }
    
    func fake(request: HTTPRequest, with result: Result<Data>) {
        send_stubbed[request] = result
    }
}

extension HTTPRequest: Hashable {
    public static func == (lhs: HTTPRequest, rhs: HTTPRequest) -> Bool {
        return lhs.url == rhs.url && lhs.method == rhs.method
    }
    
    public var hashValue: Int {
        return url.hashValue ^ method.hashValue
    }
}
