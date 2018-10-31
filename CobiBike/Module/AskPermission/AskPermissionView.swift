//
//  AskPermissionView.swift
//  CobiBike
//
//  Created by Ziad on 10/30/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import UIKit
import SnapKit

class AskPermissionView: UIView {

    let titleLabel = UILabel(style: Style.Label.title, {
        $0.textAlignment = .center;
        $0.text = "Enable Location"
    })
    
    let subtitleLabel = UILabel(style: Style.Label.subheadline, {
        $0.textAlignment = .center;
        $0.numberOfLines = 0
        $0.text = "Cobi uses you location to search for nearby bikes!"
    })
    
    let bgImageView = UIImageView(style: {
        ($0 as? UIImageView)?.image = #imageLiteral(resourceName: "map-bg")
    })
    
    let iconImageView = UIImageView(style: {
        $0.contentMode = .scaleAspectFit;
        ($0 as? UIImageView)?.image = #imageLiteral(resourceName: "location-icon")
    })
    
    let confirmButton = UIButton(style: Style.Button.primary, {
        $0.setTitle("OK, I understand", for: .normal)
    })
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            style: { $0.axis = .vertical; $0.distribution = .fill; $0.spacing = 4 },
            views: [self.titleLabel, self.subtitleLabel])
        return stackView
    }()
    
    convenience init() { self.init(frame: .zero) }
    override init(frame: CGRect) { super.init(frame: frame); _init() }
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); _init() }
    
    private func _init() {
        backgroundColor = .white
        addSubview(bgImageView)
        addSubview(iconImageView)
        addSubview(confirmButton)
        addSubview(stackView)
        
        bgImageView.snp.makeConstraints{ $0.edges.equalToSuperview() }
        iconImageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.3)
            $0.height.equalTo(iconImageView.snp.width)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.8)
        }
        
        confirmButton.snp.makeConstraints {
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
            $0.width.equalTo(confirmButton)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(confirmButton.snp.top).offset(-20)
        }
    }
}
