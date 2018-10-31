//
//  AskPermissionViewController.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import UIKit

protocol AskPermissionViewContract: class {
    func display(title: String, message: String)
    func close()
}

class AskPermissionViewController: UIViewController {
    private let alertPresenter: AlertPresenterContract
    var presenter: AskPermissionPresenterContract!

    var containerView = AskPermissionView()
    
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
        containerView.confirmButton.addTarget(self, action: #selector(onConfirmation(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.observerAuthorization()
    }
}

// MARK: - Actions
extension AskPermissionViewController {
    
    @objc func onConfirmation(_ sender: Any) {
        presenter.requestLocationService()
    }
}

extension AskPermissionViewController: AskPermissionViewContract {
    
    func display(title: String, message: String) {
        alertPresenter.present(from: self, title: title, message: message, dismissButtonTitle: "OK")
    }
    
    func close() {
        dismiss(animated: true)
    }
}
