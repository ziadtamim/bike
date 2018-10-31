//
//  AlertPresenterTests.swift
//  CobiBikeTests
//
//  Created by Ziad on 10/31/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import XCTest
@testable import CobiBike


class AlertPresenterTests: XCTestCase {
    var fakeViewController: PartiallyFakeViewController!
    var subject: AlertPresenter!
    
    override func setUp() {
        super.setUp()
        fakeViewController = PartiallyFakeViewController()
        subject = AlertPresenter()
    }
    
    
    func testPresent_tellsTheViewControllerToPresentAnAlertController() {
        subject.present(from: fakeViewController, title: "", message: "", dismissButtonTitle: "")
        XCTAssertTrue(fakeViewController.present_wasCalled)
        XCTAssertTrue(fakeViewController.present_wasCalled_withArgs?.viewControllerToPresent is UIAlertController)
    }
    
    func testPresent_doesNotConfigureCallbackForPresentation() {
        subject.present(from: fakeViewController, title: "", message: "", dismissButtonTitle: "")
        XCTAssertNil(fakeViewController.present_wasCalled_withArgs?.completion)
    }
    
    func testPresent_configuresTheAlertWithTitleAndMessage() {
        subject.present(from: fakeViewController, title: "Some alert title", message: "Detailed message", dismissButtonTitle: "")
        
        let alertController = fakeViewController.present_wasCalled_withArgs?.viewControllerToPresent as? UIAlertController
        XCTAssertEqual(alertController?.title, "Some alert title")
        XCTAssertEqual(alertController?.message, "Detailed message")
    }
}
