//
//  ProfilePaymentCell.swift
//  Response
//
//  Created by Keivan Shahida on 3/10/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit

class ProfilePaymentCell: UITableViewCell {
    
    //MARK: - INITIALIZATION
    var iconView: UIImageView!
    
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    var descriptionStackView: UIStackView!

    var amountLabel: UILabel!
    var amount: Double = 0.00

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none

        contentView.layer.cornerRadius = 5
        contentView.backgroundColor = .responseBlue
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(20, 20, 0, 20))
        
        iconView = UIImageView(image: #imageLiteral(resourceName: "tempLogo"))
        
        titleLabel = UILabel()
        titleLabel.text = "UNICEF"
        titleLabel.textColor = .white
        titleLabel.font = ._14ProximaBold
        titleLabel.sizeToFit()
        
        subtitleLabel = UILabel()
        subtitleLabel.text = "Syrian Refugee Support"
        subtitleLabel.textColor = .white
        subtitleLabel.font = ._14ProximaRegular
        subtitleLabel.sizeToFit()
        
        descriptionStackView = UIStackView()
        descriptionStackView.axis = UILayoutConstraintAxis.vertical
        descriptionStackView.distribution = UIStackViewDistribution.equalSpacing
        descriptionStackView.alignment = UIStackViewAlignment.leading
        descriptionStackView.spacing = 0.0
        
        descriptionStackView.addArrangedSubview(titleLabel)
        descriptionStackView.addArrangedSubview(subtitleLabel)
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        
        amountLabel = UILabel()
        amountLabel.text = "$\(amount)"
        amountLabel.textColor = .white
        amountLabel.font = ._16ProximaBold
        amountLabel.sizeToFit()
        
        addSubview(iconView)
        addSubview(descriptionStackView)
        addSubview(amountLabel)
        
        setConstraints()
    }
    
    // MARK: - CONSTRAINTS
    
    func setConstraints() {
        
        iconView.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(40)
        }

        descriptionStackView.snp.makeConstraints{ (make) -> Void in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.top.equalTo(contentView.snp.top).offset(14)
        }

        amountLabel.snp.updateConstraints { make in
            make.right.equalTo(contentView.snp.right).offset(-20)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
