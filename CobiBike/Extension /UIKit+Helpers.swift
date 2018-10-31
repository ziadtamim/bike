//
//  UIKit+Helpers.swift
//  CobiBike
//
//  Created by Ziad on 10/30/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import UIKit

extension UIButton {
    @nonobjc convenience init(type: UIButtonType = .system, style: ((UIButton) -> Void)...) {
        self.init(type: type)
        style.forEach { $0(self) }
    }
}

extension UILabel {
    @nonobjc convenience init(style: ((UILabel) -> Void)...) {
        self.init()
        style.forEach { $0(self) }
    }
}

extension UIView {
    @nonobjc convenience init(style: ((UIView) -> Void)...) {
        self.init(frame: .zero)
        style.forEach { $0(self) }
    }
}

extension UIStackView {
    @nonobjc convenience init(style: ((UIStackView) -> Void)..., views: [UIView]) {
        self.init(arrangedSubviews: views)
        style.forEach { $0(self) }
    }
}

extension UITextField {
    @nonobjc convenience init(style: ((UITextField) -> Void)...) {
        self.init(frame: .zero)
        style.forEach { $0(self) }
    }
}

extension UIActivityIndicatorView {
    @nonobjc convenience init(style: ((UIActivityIndicatorView) -> Void)..., indicatorStyle: UIActivityIndicatorViewStyle = .gray) {
        self.init(activityIndicatorStyle: indicatorStyle)
        style.forEach { $0(self) }
    }
}

extension UICollectionView {
    @nonobjc convenience init(style: ((UICollectionView) -> Void)..., layout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
        self.init(frame: .zero, collectionViewLayout: layout)
        style.forEach { $0(self) }
    }
}

