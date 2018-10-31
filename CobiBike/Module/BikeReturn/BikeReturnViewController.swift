//
//  BikeReturnViewController.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import UIKit

protocol BikeReturnViewContract: class {
    func display(title: String, message: String)
    func displayPin(_ pin: String)
    func close()
}

class BikeReturnViewController: UIViewController {
    private let alertPresenter: AlertPresenterContract
    var presenter: BikeReturnPresenterContract!
    
    let containerView = BikeReturnView()
    
    init(alertPresenter: AlertPresenterContract = AlertPresenter()) {
        self.alertPresenter = alertPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = containerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setupInitialState()
        containerView.returnButton.addTarget(self, action: #selector(onReturn(_:)), for: .touchUpInside)
    }
    
}

// MARK: Actions
extension BikeReturnViewController {
    
    @objc func onReturn(_ sender: Any) {
        containerView.spinner.startAnimating()
        presenter.returnBike()
    }
}

extension BikeReturnViewController: BikeReturnViewContract {
    
    func display(title: String, message: String) {
        containerView.spinner.stopAnimating()
        alertPresenter.present(from: self, title: title, message: message, dismissButtonTitle: "OK")
    }
    
    func displayPin(_ pin: String) {
        containerView.pinLabel.text = pin
    }
    
    func close() {
        dismiss(animated: true)
    }
}
