//
//  UserDefaults+Helpers.swift
//  CobiBike
//
//  Created by Ziad on 10/30/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    class func saveValue(_ value: Any?, forKey key: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(value, forKey: key)
        userDefaults.synchronize()
    }
}
