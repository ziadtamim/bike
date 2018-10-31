//
//  NewBikeViewController.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import UIKit

protocol NewBikeViewControllerDelegate: class {
    func didEnterBikeName(name: String)
    func didEnterBikePin(pin: String)
    func didChooseBikeColor(color: String)
}

protocol NewBikeViewContract: class {
    func display(title: String, message: String)
    func close()
}

class NewBikeViewController: UIViewController {
    private let alertPresenter: AlertPresenterContract
    var presenter: NewBikePresenterContract!
    
    private enum CellKind: Int {
        case name, pin, color
    }
    
    var containerView = NewBikeView()
    
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
        title = "New Bike"
        configureNavigationItems()
        configureCollectionView()
    }
    
    private func configureNavigationItems() {
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "close-icon"), style: .plain, target: self, action: #selector(onClose(_:)))
    }
    
    private func configureCollectionView() {
        containerView.collectionView.dataSource = self
        containerView.collectionView.delegate = self
        
        containerView.collectionView.register(NameViewCell.self)
        containerView.collectionView.register(PinViewCell.self)
        containerView.collectionView.register(ColorViewCell.self)
    }
    
    fileprivate func moveCollectionViewToNextPage() {
        guard let nextIndexPath = containerView.collectionView.nextIndexPath() else { return }
        containerView.collectionView.scrollToItem(at: nextIndexPath, at: .left, animated: true)
    }
}

extension NewBikeViewController {
    
    @objc func onSend(_ sender: Any) {
        presenter.createBike()
    }
    
    @objc func onClose(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension NewBikeViewController: NewBikeViewControllerDelegate {
    
    func didEnterBikeName(name: String) {
        presenter.setValue(value: name, forKey: "name")
        moveCollectionViewToNextPage()
    }
    
    func didEnterBikePin(pin: String) {
        presenter.setValue(value: pin, forKey: "pin")
        moveCollectionViewToNextPage()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .done, target: self, action: #selector(onSend(_:)))
    }
    
    func didChooseBikeColor(color: String) {
        presenter.setValue(value: color, forKey: "color")
    }
}

extension NewBikeViewController: NewBikeViewContract {
    
    func display(title: String, message: String) {
        alertPresenter.present(from: self, title: title, message: message, dismissButtonTitle: "OK")
    }
    
    func close() {
        dismiss(animated: true)
    }
}

extension NewBikeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch CellKind(rawValue: indexPath.row)! {
        case .name:
            let cell: NameViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            return cell
        case .pin:
            let cell: PinViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            return cell
        case .color:
            let cell: ColorViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            return cell
        }
    }
}

extension NewBikeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
