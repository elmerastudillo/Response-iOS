//
//  AmountButton.swift
//  Response
//
//  Created by Elmer Astudillo on 4/4/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit

class AmountButton: UIButton {
    
    var amount : String?
    
    init(amount: String, frame: CGRect) {
        super.init(frame: frame)
        self.amount = amount
        self.setBackgroundColor(color: .clear, forState: .normal)
        self.setBackgroundColor(color: .responseBlue, forState: .selected)
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        let textAmount = "$\(amount)"
        self.setTitle(textAmount, for: .normal)
        self.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 18.0)
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
