//
//  ProfilePaymentHeaderView.swift
//  Response
//
//  Created by Keivan Shahida on 3/10/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit

protocol CollapsibleHeaderViewDelegate {
    func toggleSection(header: ProfilePaymentHeaderView, section: Int)
}

class ProfilePaymentHeaderView: UITableViewHeaderFooterView {

    var delegate: CollapsibleHeaderViewDelegate?
    var section: Int!
    
    var headerTitleLabel: UILabel!
    var paymentTotalLabel: UILabel!
        
    // MARK: - INITIALIZATION
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layer.backgroundColor = UIColor.responseDarkGrey.cgColor
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeader)))
       
    }
    
    func customInit(section: Int, delegate: CollapsibleHeaderViewDelegate){
        self.section = section
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectHeader(gestureRecognizer: UITapGestureRecognizer){
        guard let cell = gestureRecognizer.view as? ProfilePaymentHeaderView else {
            return
        }
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    // MARK: - LAYOUT
    override func layoutSubviews() {
        super.layoutSubviews()
        headerTitleLabel = UILabel()
        headerTitleLabel.text = "Monthly Payment"
        headerTitleLabel.textColor = .white
        headerTitleLabel.font = ._16ProximaSemibold
        headerTitleLabel.sizeToFit()
        
        paymentTotalLabel = UILabel()
        paymentTotalLabel.text = "$29.95"
        paymentTotalLabel.textColor = .white
        paymentTotalLabel.font = ._16ProximaSemibold
        paymentTotalLabel.sizeToFit()
        
        addSubview(headerTitleLabel)
        addSubview(paymentTotalLabel)
        
        setConstraints()
    }
    
    // MARK: - CONSTRAINTS
    func setConstraints() {
        headerTitleLabel.snp.makeConstraints{ (make) -> Void in
            make.left.equalToSuperview().offset(50)
            make.centerY.equalToSuperview()
        }
        
        paymentTotalLabel.snp.makeConstraints{ (make) -> Void in
            make.right.equalToSuperview().offset(-40)
            make.centerY.equalToSuperview()
        }
    }
}
