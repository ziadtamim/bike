//
//  NewBikeView.swift
//  CobiBike
//
//  Created by Ziad on 10/30/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import UIKit
import SnapKit

class NewBikeView: UIView {
    
    let collectionView = UICollectionView(style: Style.CollectioView.pageable, {
        $0.isScrollEnabled = false
        $0.contentInsetAdjustmentBehavior = .never
    })
    
    convenience init() { self.init(frame: .zero) }
    override init(frame: CGRect) { super.init(frame: frame); _init() }
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); _init() }
    
    private func _init() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints{ $0.edges.equalToSuperview() }
    }
}
