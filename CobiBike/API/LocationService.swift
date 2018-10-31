//
//  LocationService.swift
//  CobiBike
//
//  Created by Ziad on 10/30/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import CoreLocation

protocol LocationServiceContract {
    var notDetermined: Bool { get }
    var disabled: Bool { get }
    var denied: Bool { get }
    var currentLocation: CLLocation? { get }
    
    func observeLocationChanges(observer: @escaping (CLLocation) -> Void)
    func startUpdateLocation()
    func authorizationObserver(observer: @escaping () -> Void)
}

class LocationService: NSObject {
    static let shared = LocationService()
    
    private let locationManager: CLLocationManager
    private var didChangeAuthorization: (() -> Void)?
    private var didChangeLocation: ((CLLocation) -> Void)?
    
    
    
    override init() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1000
        super.init()
        locationManager.delegate = self
    }
}

extension LocationService: LocationServiceContract {
    
    var disabled: Bool {
        return !CLLocationManager.locationServicesEnabled()
    }
    
    var denied: Bool {
        let status = CLLocationManager.authorizationStatus()
        return status == .denied || status == .restricted
    }
    
    var notDetermined: Bool {
        return CLLocationManager.authorizationStatus() == .notDetermined
    }
    
    var currentLocation: CLLocation? {
        return locationManager.location
    }
    
    func observeLocationChanges(observer: @escaping (CLLocation) -> Void) {
        didChangeLocation = observer
    }
    
    func startUpdateLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func authorizationObserver(observer: @escaping () -> Void) {
        didChangeAuthorization = observer
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        didChangeLocation?(currentLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        didChangeAuthorization?()
    }
}
