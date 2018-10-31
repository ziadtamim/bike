//
//  NewBikeViewModel.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import Foundation

protocol NewBikePresenterContract {
    func setValue(value: String, forKey key: String)
    func createBike()
}

class NewBikePresenter {
    var bikeService: BikeServiceContract
    var locationService: LocationServiceContract
    weak var view: NewBikeViewContract!
    
    fileprivate var bikeInfo = [String: String]()
    
    init(bikeService: BikeServiceContract = BikeService(), locationService: LocationServiceContract = LocationService.shared, view: NewBikeViewContract) {
        self.bikeService = bikeService
        self.locationService = locationService
        self.view = view
    }
    
    fileprivate func update() {
        view.close()
        NotificationCenter.default.post(name: Notification.Name.BikeListItemsDidChange, object: self)
    }
}

extension NewBikePresenter: NewBikePresenterContract {
    
    func setValue(value: String, forKey key: String) {
        bikeInfo[key] = value
    }
    
    func createBike() {
        guard let name = bikeInfo["name"],
            let pin = bikeInfo["pin"],
            let color = bikeInfo["color"] else {
                view.display(title: "Oh uh", message: "You haven't chosen a color. Please choose one.")
            return
        }
        
        guard let currentLocation = locationService.currentLocation else {
            return
        }
      
        let coordinate = currentLocation.coordinate
        let location = Location(lat: coordinate.latitude, long: coordinate.longitude)
        let bike = Bike(id: "0", name: name, color: color, pin: pin, location: location, rented: false)
        
        bikeService.new(bike: bike, completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.update()
            case .failure(let error):
                self?.view.display(title: "Oh uh", message: error.localizedDescription)
            }
        })
    }
}
