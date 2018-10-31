//
//  FakeAlertPresenter.swift
//  CobiBike
//
//  Created by Ziad on 10/31/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

@testable import CobiBike
import UIKit


class FakeAlertPresenter: AlertPresenterContract {
    var present_wasCalled = false
    var present_wasCalled_withArgs: (from: UIViewController, title: String, message: String, dismissButtonTitle: String)? = nil
    
    func present(from: UIViewController, title: String, message: String, dismissButtonTitle: String) {
        present_wasCalled = true
        present_wasCalled_withArgs = (from: from, title: title, message: message, dismissButtonTitle: dismissButtonTitle)
    }
}

