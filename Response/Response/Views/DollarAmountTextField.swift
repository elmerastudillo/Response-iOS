//
//  DollarAmountTextField.swift
//  Response
//
//  Created by Elmer Astudillo on 4/4/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit
import SnapKit

class DollarAmountTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Border
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.white.cgColor
        
        //Background
        self.backgroundColor = UIColor(white: 1, alpha: 0.0)
        self.keyboardType = UIKeyboardType.decimalPad
        
        //Text
        self.textColor = UIColor.white
        self.textAlignment = NSTextAlignment.center
        self.font = UIFont(name: "ProximaNova-Bold", size: 18.0)
        self.attributedPlaceholder = NSAttributedString(string: "Enter Amount", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.40)])
        
        self.leftViewMode = UITextFieldViewMode.always
        self.leftViewMode = .always
        self.rightViewMode = UITextFieldViewMode.always
        self.rightViewMode = .always
        
        let dollarLabel = UILabel(frame: CGRect(x: 20, y: 0, width: 40, height: 22))
        dollarLabel.snp.makeConstraints { (make) in
            make.width.equalTo(40)
        }
        dollarLabel.text = "$"
        dollarLabel.clipsToBounds = false
        dollarLabel.textColor = .white
        dollarLabel.textAlignment = .center
        dollarLabel.font = ._18ProximaBold
        dollarLabel.contentMode = UIViewContentMode.center
        
        let usdLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 22))
        usdLabel.snp.makeConstraints { (make) in
            make.width.equalTo(60)
        }
        usdLabel.text = "USD"
        usdLabel.contentMode = UIViewContentMode.center
        usdLabel.clipsToBounds = false
        usdLabel.textColor = .white
        usdLabel.textAlignment = .center
        usdLabel.font = ._18ProximaBold
        self.leftView = dollarLabel
        self.rightView = usdLabel
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
    
}
