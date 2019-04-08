//
//  ProfileDescriptionCell.swift
//  Response
//
//  Created by Keivan Shahida on 3/9/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit

class ProfileDescriptionCell: UITableViewCell {

    // MARK: - INITIALIZATION
    var causesValueLabel: UILabel!
    var causesTitleLabel: UILabel!
    var causesStackView: UIStackView!
    
    var missionsValueLabel: UILabel!
    var missionsTitleLabel: UILabel!
    var missionsStackView: UIStackView!

    var organizationsValueLabel: UILabel!
    var organizationsTitleLabel: UILabel!
    var organizationsStackView: UIStackView!

    var descriptionStackView: UIStackView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = .responseBlack
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LAYOUT
    override func layoutSubviews() {
        super.layoutSubviews()
        // CAUSES
        causesValueLabel = UILabel(frame: .zero)
        causesValueLabel.text = "13"
        causesValueLabel.textColor = .white
        causesValueLabel.font = ._24ProximaBold
        causesValueLabel.sizeToFit()
        
        causesTitleLabel = UILabel(frame: .zero)
        causesTitleLabel.text = "Causes"
        causesTitleLabel.textColor = .responseLightGrey
        causesTitleLabel.font = ._14ProximaSemibold
        causesTitleLabel.sizeToFit()
        
        causesStackView = UIStackView()
        causesStackView.axis = UILayoutConstraintAxis.vertical
        causesStackView.distribution = UIStackViewDistribution.equalSpacing
        causesStackView.alignment = UIStackViewAlignment.center
        causesStackView.spacing = 0.0
        
        causesStackView.addArrangedSubview(causesValueLabel)
        causesStackView.addArrangedSubview(causesTitleLabel)
        causesStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // MISSIONS
        missionsValueLabel = UILabel(frame: .zero)
        missionsValueLabel.text = "5"
        missionsValueLabel.textColor = .white
        missionsValueLabel.font = ._24ProximaBold
        missionsValueLabel.sizeToFit()
        
        missionsTitleLabel = UILabel(frame: .zero)
        missionsTitleLabel.text = "Missions"
        missionsTitleLabel.textColor = .responseLightGrey
        missionsTitleLabel.font = ._14ProximaSemibold
        missionsTitleLabel.sizeToFit()
        
        missionsStackView = UIStackView()
        missionsStackView.axis = UILayoutConstraintAxis.vertical
        missionsStackView.distribution = UIStackViewDistribution.equalSpacing
        missionsStackView.alignment = UIStackViewAlignment.center
        missionsStackView.spacing = 0.0
        
        missionsStackView.addArrangedSubview(missionsValueLabel)
        missionsStackView.addArrangedSubview(missionsTitleLabel)
        missionsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // ORGANIZATIONS
        organizationsValueLabel = UILabel(frame: .zero)
        organizationsValueLabel.text = "8"
        organizationsValueLabel.textColor = .white
        organizationsValueLabel.font = ._24ProximaBold
        organizationsValueLabel.sizeToFit()
        
        organizationsTitleLabel = UILabel(frame: .zero)
        organizationsTitleLabel.text = "Organizations"
        organizationsTitleLabel.textColor = .responseLightGrey
        organizationsTitleLabel.font = ._14ProximaSemibold
        organizationsTitleLabel.sizeToFit()
        
        organizationsStackView = UIStackView()
        organizationsStackView.axis = UILayoutConstraintAxis.vertical
        organizationsStackView.distribution = UIStackViewDistribution.equalSpacing
        organizationsStackView.alignment = UIStackViewAlignment.center
        organizationsStackView.spacing = 0.0
        
        organizationsStackView.addArrangedSubview(organizationsValueLabel)
        organizationsStackView.addArrangedSubview(organizationsTitleLabel)
        organizationsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        //STACKVIEW OF STACKVIEWS
        
        descriptionStackView = UIStackView()
        descriptionStackView.axis = UILayoutConstraintAxis.horizontal
        descriptionStackView.distribution = UIStackViewDistribution.equalSpacing
        descriptionStackView.alignment = UIStackViewAlignment.center
        descriptionStackView.spacing = 40.0
        
        descriptionStackView.addArrangedSubview(causesStackView)
        descriptionStackView.addArrangedSubview(missionsStackView)
        descriptionStackView.addArrangedSubview(organizationsStackView)
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(descriptionStackView)
        
        setConstraints()
    }
    
    // MARK: - CONSTRAINTS
    
    func setConstraints() {
        descriptionStackView.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview() 
            make.centerY.equalToSuperview()
        }
    }
}
