//
//  NameViewCell.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import UIKit
import SnapKit

class NameViewCell: UICollectionViewCell {
    
    weak var delegate: NewBikeViewControllerDelegate?
    
    let nameTextField = UITextField(style: {
        $0.placeholder = "Name"
        $0.returnKeyType = UIReturnKeyType.next
        $0.becomeFirstResponder()
    })
    
    private func _init() {
        nameTextField.delegate = self
        addSubview(nameTextField)
        
        nameTextField.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(30)
        }
    }
    
    convenience init() { self.init(frame: .zero) }
    override init(frame: CGRect) { super.init(frame: frame); _init() }
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder); _init() }
}

extension NameViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let name = nameTextField.text, !name.isEmpty else { return false }
        delegate?.didEnterBikeName(name: name)
        return true
    }
}
