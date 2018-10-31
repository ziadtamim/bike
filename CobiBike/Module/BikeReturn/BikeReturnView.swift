//
//  BikeReturnView.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import UIKit

class BikeReturnView: UIView {
    
    let bgImageView = UIImageView(style: { ($0 as? UIImageView)?.image = #imageLiteral(resourceName: "map-bg") })
    
    let spinner = UIActivityIndicatorView()
    let returnButton = UIButton(style: Style.Button.primary, {
        $0.setTitle("Return The Bike", for: .normal)
    })
    
    let pinLabel = UILabel(style: {
        $0.textAlignment = .center;
        $0.font = UIFont.systemFont(ofSize: 50, weight: .bold)
    })
    
    let greetingLabel = UILabel(style: Style.Label.title, {
        $0.textAlignment = .center;
        $0.text = "Bike Rented, Enjoy The Ride!"
    })
    
    let instructionLabel = UILabel(style: Style.Label.subheadline, {
        $0.textAlignment = .center;
        $0.numberOfLines = 0
        $0.text = "Use this PIN to unlock your bike."
    })
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            style: { $0.axis = .vertical; $0.distribution = .fill; $0.spacing = 4 },
            views: [self.pinLabel, self.greetingLabel, self.instructionLabel])
        return stackView
    }()
    
    convenience init() { self.init(frame: .zero) }
    override init(frame: CGRect) { super.init(frame: frame); _init() }
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); _init() }
    
    private func _init() {
        backgroundColor = .white
        addSubview(bgImageView)
        addSubview(returnButton)
        addSubview(stackView)
        returnButton.addSubview(spinner)
        
        bgImageView.snp.makeConstraints{ $0.edges.equalToSuperview() }
        
        returnButton.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.width.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            if #available(iOS 11.0, *) {
                $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
            } else {
                $0.bottom.equalToSuperview().inset(20)
            }
        }
        
        stackView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.15)
            $0.center.equalToSuperview()
        }
        
        spinner.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-10)
        }
    }
}

