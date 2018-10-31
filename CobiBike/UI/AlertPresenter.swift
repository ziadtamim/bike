//
//  AlertPresenter.swift
//  CobiBike
//
//  Created by Ziad on 10/27/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import UIKit

protocol AlertPresenterContract {
    func present(from: UIViewController, title: String, message: String, dismissButtonTitle: String)
}

class AlertPresenter: AlertPresenterContract {
    func present(from: UIViewController, title: String, message: String, dismissButtonTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: dismissButtonTitle, style: .default, handler: nil)
        alertController.addAction(alertAction)
        from.present(alertController, animated: true)
    }
}
