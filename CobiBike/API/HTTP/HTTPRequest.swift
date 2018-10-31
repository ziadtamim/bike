//
//  HTTPRequest.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import Foundation
import Alamofire

struct HTTPRequest: URLRequestConvertible {
    
    enum Method: String {
        case get, post, put, delete
    }
    
    let method: Method
    let url: URL
    let params: [String: Any]?
    
    init(url: URL, method: Method = .get, params: [String: Any]? = nil) {
        self.url = url
        self.method = method
        self.params = params
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        if method == .post {
            request = try JSONEncoding.default.encode(request, with: params)
        } else {
            request = try URLEncoding.default.encode(request, with: params)
        }
        return request
    }
}
