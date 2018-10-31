//
//  BikeInfoView.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import UIKit
import SnapKit

class BikeRentView: UIView {
    
    let containerView = UIView(style: {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    })
    
    let nameLabel = UILabel(style: Style.Label.subheadline, {
        $0.textColor = UIColor.black
    })
    
    let spinner = UIActivityIndicatorView()
    let rentButton = UIButton(style: Style.Button.primary, {
        $0.setTitle("Rent Bike", for: .normal)
        $0.snp.makeConstraints { $0.height.equalTo(40) }
    })
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            style: { $0.axis = .vertical; $0.distribution = .equalSpacing; $0.spacing = 5 },
            views: [self.nameLabel, self.rentButton])
        return stackView
    }()
    
    private func _init() {
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        addSubview(containerView)
        containerView.addSubview(stackView)
        rentButton.addSubview(spinner)
        
        stackView.snp.makeConstraints{ $0.edges.equalToSuperview().inset(10) }
        containerView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.12)
            $0.centerX.equalToSuperview()
            
            if #available(iOS 11.0, *) {
                $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
            } else {
                $0.bottom.equalToSuperview().inset(10)
            }
        }
        
        spinner.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-10)
        }
    }
    
    convenience init() { self.init(frame: .zero) }
    override init(frame: CGRect) { super.init(frame: frame); _init() }
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); _init() }
}
