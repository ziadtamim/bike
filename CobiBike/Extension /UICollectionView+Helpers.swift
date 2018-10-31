//
//  UICollectionView+Helpers.swift
//  CobiBike
//
//  Created by Ziad on 10/30/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_:T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

extension UICollectionView {
    
    var maximumIndexPath: IndexPath {
        let lastSection = max(0, numberOfSections - 1)
        let lastItem = max(0, numberOfItems(inSection: lastSection) - 1)
        return IndexPath(item: lastItem, section: lastSection)
    }
    
    func indexPath(after indexPath: IndexPath) -> IndexPath? {
        guard indexPath < maximumIndexPath else { return nil }
        return IndexPath(row: indexPath.row + 1, section: indexPath.section)
    }
    
    func nextIndexPath() -> IndexPath? {
        guard let visibleIndexPath = indexPathsForVisibleItems.first else { return nil }
        return indexPath(after: visibleIndexPath)
    }
}
