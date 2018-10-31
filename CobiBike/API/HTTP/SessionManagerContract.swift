//
//  SessionManagerContract.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import Foundation
import Alamofire

protocol SessionManagerContract {
    func request(_ request: URLRequestConvertible, completionHandler: @escaping (DefaultDataResponse) -> Void)
}

extension SessionManager: SessionManagerContract {
    
    func request(_ request: URLRequestConvertible, completionHandler: @escaping (DefaultDataResponse) -> Void) {
        self.request(request).response(completionHandler: completionHandler)
    }
}
