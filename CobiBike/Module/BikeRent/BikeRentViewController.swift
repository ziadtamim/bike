//
//  BikeRentViewController.swift
//  CobiBike
//
//  Created by Ziad on 10/30/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import UIKit

protocol BikeRentViewContract: class {
    func update(id: String, name: String)
    func display(title: String, message: String)
    func close()
}

class BikeRentViewController: UIViewController {
    private let alertPresenter: AlertPresenterContract
    var presenter: BikeRentPresenterContract!
    
    let containerView = BikeRentView()
    
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
        containerView.rentButton.addTarget(self, action: #selector(onRent(_:)), for: .touchUpInside)
        containerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClose(_:))))
    }
}

// MARK: - Actions
extension BikeRentViewController {
    
    @objc func onRent(_ sender: Any) {
        containerView.spinner.startAnimating()
        presenter.rent()
    }
    
    @objc func onClose(_ sender: Any) {
        close()
    }
}

extension BikeRentViewController: BikeRentViewContract {
    
    func display(title: String, message: String) {
        containerView.spinner.stopAnimating()
        alertPresenter.present(from: self, title: title, message: message, dismissButtonTitle: "OK")
    }
    
    func update(id: String, name: String) {
        containerView.nameLabel.text = "\(id). \(name)"
    }
    
    func close() {
        dismiss(animated: true)
    }
}
