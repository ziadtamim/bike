//
//  BikeListViewModel.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import Foundation
import CoreLocation

extension Notification.Name {
    static let BikeListItemsDidChange = Notification.Name("BikeList.ItemsDidChange")
}

protocol BikeListPresenterContract {
    func setupInitialState()
    func fetchBikes(in location: CLLocation)
    func presentAddNewBike()
    func presentBikeRentWithBike(_ bike: Bike)
}

class BikeListPresenter {
    
    let locationService: LocationServiceContract
    let bikeService: BikeServiceContract
    weak var view: BikeListViewContract!
    let router: RouterContract
    
    init(locationService: LocationService = LocationService.shared, bikeService: BikeServiceContract = BikeService(), view: BikeListViewContract, router: RouterContract) {
        self.locationService = locationService
        self.bikeService = bikeService
        self.view = view
        self.router = router
        
        registerNotifications()
    }
    
    fileprivate func checkLocationServicePermission() {
        guard locationService.disabled || locationService.notDetermined else {
            locationService.startUpdateLocation()
            return
        }
        router.presentAskPermission()
    }
    
    fileprivate func checkRentedBike() {
        guard let _ = UserDefaults.standard.value(forKey: Key.RentedBike) as? Data else { return }
        router.presentBikeReturn(animated: true)
    }
    
    fileprivate func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(setupInitialState), name: Notification.Name.BikeListItemsDidChange, object: nil)
    }
}

extension BikeListPresenter: BikeListPresenterContract {
    
    @objc func setupInitialState() {
        checkLocationServicePermission()
        checkRentedBike()
        locationService.observeLocationChanges { (location) in
            self.view.centerMapView(on: location)
            self.fetchBikes(in: location)
        }
    }
    
    func fetchBikes(in location: CLLocation) {
        let coordinate = location.coordinate
        bikeService.get(location: Location(lat: coordinate.latitude, long: coordinate.longitude)) { (result) in
            switch result {
            case .success(let bikes):
                self.view.addAnnotations(annotations: bikes.map(BikeAnnotation.init))
            case let .failure(error):
                self.view.display(title: "Oh uh.", message: error.localizedDescription)
            }
        }
    }
    
    func presentAddNewBike() {
        router.presentNewBike()
    }
    
    func presentBikeRentWithBike(_ bike: Bike) {
        router.presentBikeRentWithBike(bike)
    }
}
