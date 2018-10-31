//
//  Router.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import UIKit

protocol RouterContract {
    func presentAskPermission()
    func presentBikeList()
    func presentNewBike()
    func presentBikeReturn(animated: Bool)
    func presentBikeRentWithBike(_ bike: Bike)
}

class Router {
    private weak var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
    }
}

extension Router: RouterContract {
    
    func presentBikeList() {
        let view = BikeListViewController()
        let presenter = BikeListPresenter(view: view, router: self)
        view.presenter = presenter
        
        let navigationController = UINavigationController(rootViewController: view)
        navigationController.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController
    }
    
    func presentBikeRentWithBike(_ bike: Bike) {
        let view = BikeRentViewController()
        let presenter = BikeRentPresenter(bike: bike, view: view, router: self)
        view.presenter = presenter
        
        view.modalTransitionStyle = .crossDissolve
        view.modalPresentationStyle = .overCurrentContext
        window?.rootViewController?.present(view, animated: true)
    }
        
    func presentAskPermission() {
        let view = AskPermissionViewController()
        let presenter = AskPermissionPresenter(view: view)
        view.presenter = presenter
        
        view.modalTransitionStyle = .crossDissolve
        window?.rootViewController?.present(view, animated: false)
    }
    
    func presentNewBike() {
        let view = NewBikeViewController()
        let presenter = NewBikePresenter(view: view)
        view.presenter = presenter
        
        window?.rootViewController?.present(UINavigationController(rootViewController: view), animated: true)
    }
    
    func presentBikeReturn(animated: Bool) {
        let view = BikeReturnViewController()
        let presenter = BikeReturnPresenter(view: view)
        view.presenter = presenter
        
        view.modalTransitionStyle = .crossDissolve
        window?.rootViewController?.present(view, animated: animated)
    }
}
