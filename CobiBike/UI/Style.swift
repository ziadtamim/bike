//
//  Style.swift
//  CobiBike
//
//  Created by Ziad on 10/30/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import UIKit

enum Style {
    enum Label {
        static func title(_ label: UILabel) {
            label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        }
        
        static func subheadline(_ label: UILabel) {
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.gray
        }
        
        static func body(_ label: UILabel) {
            label.font = UIFont.systemFont(ofSize: 16)
        }
    }
    
    enum Button {
        static func primary(_ button: UIButton) {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor.blue
            button.layer.cornerRadius = 4
            button.layer.masksToBounds = true
        }
    }
    
    enum CollectioView {
        static func pageable(_ collectionView: UICollectionView) {
            collectionView.backgroundColor = .white
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.isPagingEnabled = true
            
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
            }
        }
    }
}
