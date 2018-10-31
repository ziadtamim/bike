//
//  Result+MiniCheckout.swift
//  CobiBike
//
//  Created by Ziad on 10/31/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import Foundation
import Alamofire

extension Result: Equatable where Value: Equatable {
    public static func ==(lhs: Result, rhs: Result) -> Bool {
        switch (lhs, rhs) {
        case let (.success(lhsValue), .success(rhsValue)):
            return lhsValue == rhsValue
        case let (.failure(lhsValue as NSError), .failure(rhsValue as NSError)):
            return lhsValue == rhsValue
        default:
            return false
        }
    }
}
