//
//  HTTPClient.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import Foundation
import Alamofire

protocol HTTPClientContract {
    
    func send(request: HTTPRequest, completion: @escaping (Result<Data>) -> Void)
}

class HTTPClient: HTTPClientContract {
    private let manager: SessionManagerContract
    private let responseHandler: HTTPResponseHandlerContract
    
    init(manager: SessionManagerContract = SessionManager.default, responseHandler: HTTPResponseHandlerContract = HTTPResponseHandler()) {
        self.manager = manager
        self.responseHandler = responseHandler
    }
    
    func send(request: HTTPRequest, completion: @escaping (Result<Data>) -> Void) {
        manager.request(request) { dataResponse in
            let result = self.responseHandler.handle(dataResponse: dataResponse)
            completion(result)
        }
    }
}
