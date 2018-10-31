//
//  HTTPError.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import Foundation

enum HTTPError: Error {
    case invalidValue(String)
    case statusCode(Int)
    case emptyResponse
}

