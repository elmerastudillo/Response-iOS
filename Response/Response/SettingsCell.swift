//
//  SettingsCell.swift
//  Response
//
//  Created by Keivan Shahida on 4/8/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {

    // MARK: - INITIALIZATION
    
    var cellTitleLabel = UILabel()
    var title: String = "" {
        didSet {
            cellTitleLabel.text = title
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.backgroundColor = .responseBlack
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LAYOUT
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        cellTitleLabel = UILabel()
        cellTitleLabel.text = title
        cellTitleLabel.textColor = .white
        cellTitleLabel.font = ._14ProximaRegular
        cellTitleLabel.sizeToFit()
        addSubview(cellTitleLabel)
        setConstraints()
    }
    
    // MARK: - CONSTRAINTS
    func setConstraints() {
        cellTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
    }
}
