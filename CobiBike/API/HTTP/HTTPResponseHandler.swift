//
//  HTTPResponseHandler.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import Foundation
import Alamofire

protocol HTTPResponseHandlerContract {
    func handle(dataResponse: DefaultDataResponse) -> Result<Data>
}

struct HTTPResponseHandler: HTTPResponseHandlerContract {
    func handle(dataResponse: DefaultDataResponse) -> Result<Data> {
        if let error = dataResponse.error {
            return .failure(error)
        } else if let statusCode = dataResponse.response?.statusCode, statusCode >= 400 {
            return .failure(HTTPError.statusCode(statusCode))
        } else if let data = dataResponse.data {
            return .success(data)
        } else {
            return .failure(HTTPError.emptyResponse)
        }
    }
}
