//
//  SettingsHeaderView.swift
//  Response
//
//  Created by Keivan Shahida on 4/8/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit

class SettingsHeaderView: UITableViewHeaderFooterView {

    var headerTitleLabel = UILabel()
    var title: String = "" {
        didSet {
            headerTitleLabel.text = title
        }
    }
    
    // MARK: - INITIALIZATION
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layer.backgroundColor = UIColor.clear.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LAYOUT
    override func layoutSubviews() {
        headerTitleLabel = UILabel()
        headerTitleLabel.text = title
        headerTitleLabel.textColor = .white
        headerTitleLabel.font = ._14ProximaBold
        headerTitleLabel.sizeToFit()
        addSubview(headerTitleLabel)
        setConstraints()
    }
    
    // MARK: - CONSTRAINTS
    func setConstraints() {
        headerTitleLabel.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
    }
}
