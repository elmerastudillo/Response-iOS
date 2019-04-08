//
//  UpdatesHeaderView.swift
//  Response
//
//  Created by Keivan Shahida on 3/10/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit

class UpdatesHeaderView: UITableViewHeaderFooterView {

    var headerTitleLabel: UILabel!
    
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
        headerTitleLabel.text = "OTHER RECENT UPDATES"
        headerTitleLabel.textColor = .responseLightGrey
        headerTitleLabel.font = ._12ProximaRegular
        headerTitleLabel.sizeToFit()
        addSubview(headerTitleLabel)
        setConstraints()
    }
    
    // MARK: - CONSTRAINTS
    func setConstraints() {
        headerTitleLabel.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
}
