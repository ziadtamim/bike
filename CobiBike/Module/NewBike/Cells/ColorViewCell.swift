//
//  ColorViewCell.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import UIKit
import Hue

class ColorViewCell: UICollectionViewCell {
    
    weak var delegate: NewBikeViewControllerDelegate?
    
    var lastSelectedIndex = -1
    
    var colorButtons = [UIButton]()
    let colors = ["4A4A4A", "417505", "D0021B", "FF9500"]
    
    let instructionLabel = UILabel(style: Style.Label.subheadline, {
        $0.textAlignment = .center;
        $0.text = "Choose your bike’s color"
    })
    
    private func _init() {
        addSubview(instructionLabel)
        
        colors.enumerated().forEach { index, color in
            let button = UIButton(style: {
                $0.tag = index
                $0.backgroundColor = UIColor(hex: color)
                $0.setTitleColor(UIColor.white, for: .normal)
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
                $0.layer.cornerRadius = 20
                $0.layer.masksToBounds = true
                $0.addTarget(self, action: #selector(self.onTapColor(_:)), for: .touchUpInside)
                $0.snp.makeConstraints { $0.size.equalTo(40) }
            })
            self.colorButtons.append(button)
        }
        
        let stackView = UIStackView(style: { $0.distribution = .fill; $0.spacing = 10 },
                                    views: colorButtons)
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.width.equalTo(190)
            $0.top.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
        }
        
        instructionLabel.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    convenience init() { self.init(frame: .zero) }
    override init(frame: CGRect) { super.init(frame: frame); _init() }
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); _init() }
}

extension ColorViewCell {
    
    @objc func onTapColor(_ sender: UIButton) {
        if lastSelectedIndex > -1 {
            colorButtons[lastSelectedIndex].setTitle("", for: .normal)
        }
        sender.setTitle("S", for: .normal)
        lastSelectedIndex = sender.tag
        
        let color = colors[sender.tag]
        delegate?.didChooseBikeColor(color: color)
    }
}
