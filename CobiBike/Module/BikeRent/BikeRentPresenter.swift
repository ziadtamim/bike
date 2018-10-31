//
//  BikeRentPresenter.swift
//  CobiBike
//
//  Created by Ziad on 10/30/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import Foundation

protocol BikeRentPresenterContract {
    func setupInitialState()
    func rent()
}

class BikeRentPresenter {
    let bikeService: BikeServiceContract
    weak var view: BikeRentViewContract!
    let router: RouterContract
    let bike: Bike
    
    init(bikeService: BikeServiceContract = BikeService(), bike: Bike, view: BikeRentViewContract, router: RouterContract) {
        self.bikeService = bikeService
        self.bike = bike
        self.view = view
        self.router = router
    }
    
    fileprivate func update() {
        view.close()
        UserDefaults.saveValue(try? PropertyListEncoder().encode(bike), forKey: Key.RentedBike)
        NotificationCenter.default.post(name: Notification.Name.BikeListItemsDidChange, object: self)
    }
}

extension BikeRentPresenter: BikeRentPresenterContract {
    
    func setupInitialState() {
        view.update(id: bike.id, name: bike.name)
    }
    
    func rent() {
        bikeService.rent(id: bike.id) { [weak self] (result) in
            switch result {
            case .success(_):
                self?.update()
            case .failure(let error):
                self?.view.display(title: "Oh uh", message: error.localizedDescription)
            }
        }
    }
}
