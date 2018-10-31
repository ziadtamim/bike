//
//  BikeListViewController.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

protocol BikeListViewContract: class {
    func centerMapView(on location: CLLocation)
    func display(title: String, message: String)
    func addAnnotations(annotations: [BikeAnnotation])
}

class BikeListViewController: UIViewController {
    private let alertPresenter: AlertPresenterContract
    var presenter: BikeListPresenterContract!
    
    let mapView = MKMapView()
    
    init(alertPresenter: AlertPresenterContract = AlertPresenter()) {
        self.alertPresenter = alertPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView()
        setNewBikeLayout()
        presenter.setupInitialState()
    }
    
    private func configureMapView() {
        mapView.delegate = self
        mapView.showsUserLocation = true
    }
    
    func setNewBikeLayout() {
        let newBikeButton = UIButton(style: Style.Button.primary, {
            $0.setTitle("Add new Bike", for: .normal)
        })
        mapView.addSubview(newBikeButton)
        
        newBikeButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
            if #available(iOS 11.0, *) {
                $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            } else {
                $0.bottom.equalToSuperview().inset(10)
            }
        }
        
        newBikeButton.addTarget(self, action: #selector(onAddNewBike(_:)), for: .touchUpInside)
    }
}

extension BikeListViewController {
    
    @objc func onAddNewBike(_ sender: Any) {
        presenter.presentAddNewBike()
    }
}

extension BikeListViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation, animated: true)
        guard let annotation = view.annotation as? BikeAnnotation else { return }
        presenter.presentBikeRentWithBike(annotation.bike)
    }
}

extension BikeListViewController: BikeListViewContract {
    
    func display(title: String, message: String) {
        alertPresenter.present(from: self, title: title, message: message, dismissButtonTitle: "OK")
    }
    
    func centerMapView(on location: CLLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func addAnnotations(annotations: [BikeAnnotation]) {
        mapView.addAnnotations(annotations)
    }
}

