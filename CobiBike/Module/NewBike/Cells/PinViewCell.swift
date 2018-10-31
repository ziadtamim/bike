//
//  PinViewCell.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import UIKit

class PinViewCell: UICollectionViewCell {
    
    weak var delegate: NewBikeViewControllerDelegate?
    
    let pinTextField = UITextField(style: {
        $0.placeholder = "0000"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        $0.keyboardType = UIKeyboardType.numbersAndPunctuation
        $0.returnKeyType = UIReturnKeyType.next
        $0.becomeFirstResponder()
    })
    
    let instructionLabel = UILabel(style: Style.Label.subheadline, {
        $0.textAlignment = .center;
        $0.text = "Lock your bike using a PIN"
    })
    
    private func _init() {
        pinTextField.delegate = self
        addSubview(pinTextField)
        addSubview(instructionLabel)
        
        pinTextField.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(30)
        }
        
        instructionLabel.snp.makeConstraints {
            $0.top.equalTo(pinTextField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    convenience init() { self.init(frame: .zero) }
    override init(frame: CGRect) { super.init(frame: frame); _init() }
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); _init() }
}

extension PinViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let pin = pinTextField.text, pin.count >= 4 else { return false }
        textField.resignFirstResponder()
        delegate?.didEnterBikePin(pin: pin)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard !string.isEmpty else { return true }
        guard CharacterSet.decimalDigits.contains(Unicode.Scalar(string)!) else { return false }
        guard let pin = textField.text else { return true }
        return (pin.count < 4)
    }
}
