//
//  AskPermissionViewModel.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import Foundation

protocol AskPermissionPresenterContract {
    func requestLocationService()
    func observerAuthorization()
}

class AskPermissionPresenter {
    
    let locationService: LocationServiceContract
    weak var view: AskPermissionViewContract!
    
    init(locationService: LocationServiceContract = LocationService.shared, view: AskPermissionViewContract) {
        self.locationService = locationService
        self.view = view
    }
}

extension AskPermissionPresenter: AskPermissionPresenterContract {
    
    func requestLocationService() {
        guard !locationService.disabled else {
            view.display(title: "Location", message: "Location Services must be enabled before Cobi can use your current location. Please enable Location Services from the Settings app.")
            return
        }
        
        guard !locationService.denied else {
            view.display(title: "Location", message: "Cobi needs permission to access your device's current location in order to fetch nearby bikes. Please update your privacy settings.")
            return
        }
        locationService.startUpdateLocation()
    }
    
    func observerAuthorization() {
        locationService.authorizationObserver {
            guard !self.locationService.notDetermined else { return }
            self.view.close()
        }
    }
}
