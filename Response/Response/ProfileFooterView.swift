//
//  ProfileFooterView.swift
//  Response
//
//  Created by Keivan Shahida on 3/10/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit

protocol ProfileFooterDelegate {
    func viewSettings()
    func viewPastTransactions()
}

class ProfileFooterView: UITableViewHeaderFooterView {

    // MARK: - INITIALIZATION
    var profileFooterDelegate: ProfileFooterDelegate!

    var settingsButton: UIButton!
    var pastTransactionsButton: UIButton!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layer.backgroundColor = UIColor.clear.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LAYOUT
    override func layoutSubviews() {
        
        pastTransactionsButton = UIButton()
        pastTransactionsButton.setTitle("View Past Transactions", for: .normal)
        pastTransactionsButton.titleLabel?.textColor = .white
        pastTransactionsButton.titleLabel?.font = ._14ProximaSemibold
        pastTransactionsButton.addTarget(self, action: #selector(viewPastTransactions), for: .touchUpInside)
        addSubview(pastTransactionsButton)
        
        settingsButton = UIButton()
        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.titleLabel?.textColor = .white
        settingsButton.titleLabel?.font = ._14ProximaBold
        settingsButton.layer.cornerRadius = 5.0
        settingsButton.layer.borderWidth = 1.0
        settingsButton.layer.borderColor = UIColor.responseLightGrey.cgColor
        settingsButton.addTarget(self, action: #selector(viewSettings), for: .touchUpInside)
        addSubview(settingsButton)
        
        setConstraints()
    }
    
    // MARK: - CONSTRAINTS
    func setConstraints() {
        
        pastTransactionsButton.snp.makeConstraints{ (make) -> Void in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(20)
            make.top.equalToSuperview().offset(20)
        }
        
        settingsButton.snp.makeConstraints{ (make) -> Void in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(60)
            make.top.equalTo(pastTransactionsButton.snp.bottom).offset(20)
        }

    }
    
    // MARK: - BUTTONS
    
    @objc func viewSettings() {
        profileFooterDelegate.viewSettings()
    }
    
    @objc func viewPastTransactions() {
        profileFooterDelegate.viewPastTransactions()
    }
}
