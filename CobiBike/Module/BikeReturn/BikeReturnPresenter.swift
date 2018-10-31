//
//  BikeReturnPresenter.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import Foundation

protocol BikeReturnPresenterContract {
    func returnBike()
    func setupInitialState()
}

class BikeReturnPresenter {
    let bikeService: BikeServiceContract
    weak var view: BikeReturnViewContract!
    
    var rentedBike: Bike!
    
    init(bikeService: BikeServiceContract = BikeService(), view: BikeReturnViewContract) {
        self.bikeService = bikeService
        self.view = view
    }
    
    fileprivate func reset() {
        view.close()
        UserDefaults.standard.removeObject(forKey: Key.RentedBike)
        NotificationCenter.default.post(name: Notification.Name.BikeListItemsDidChange, object: self)
    }
}

extension BikeReturnPresenter: BikeReturnPresenterContract {
    
    func setupInitialState() {
        guard let data = UserDefaults.standard.value(forKey: Key.RentedBike) as? Data else { return }
        guard let rentedBike = try? PropertyListDecoder().decode(Bike.self, from: data) else { return }
        self.rentedBike = rentedBike
        view.displayPin(rentedBike.pin)
    }
    
    func returnBike() {
        bikeService.return(id: rentedBike.id) { [weak self] (result) in
            switch result {
            case .success(_):
                self?.reset()
            case .failure(let error):
                self?.view.display(title: "Oh uh", message: error.localizedDescription)
            }
        }
    }
}
