//
//  UserProfileDashboardCell.swift
//  Response
//
//  Created by Keivan Shahida on 3/2/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit

class ProfileProgressCell: UITableViewCell {
    
    // MARK: - INITIALIZATION
    var progressView: ProgressView!
    
    var goalValueLabel: UILabel!
    var goalTitleLabel: UILabel!
    
    var didAnimate: Bool!
    
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
        progressView = ProgressView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        progressView.didAnimate = didAnimate
        print("progressView loading")
        goalValueLabel = UILabel(frame: .zero)
        goalValueLabel.text = "$97"
        goalValueLabel.textColor = .white
        goalValueLabel.font = ._48ProximaBold
        goalValueLabel.sizeToFit()

        goalTitleLabel = UILabel(frame: .zero)
        goalTitleLabel.text = "GOAL"
        goalTitleLabel.textColor = .responseLightGrey
        goalTitleLabel.font = ._14ProximaSemibold
        goalTitleLabel.sizeToFit()
        
        addSubview(progressView)
        addSubview(goalValueLabel)
        addSubview(goalTitleLabel)
        
        setConstraints()
    }
    
    // MARK: - CONSTRAINTS
    func setConstraints() {
        progressView.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(200)
            make.width.equalTo(200)
        }
        
        goalValueLabel.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(90)
        }
        
        goalTitleLabel.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(goalValueLabel.snp.bottom)
        }
        
        if !didAnimate {
            progressView.animateCircle(duration: 0.0)
        }
    }
}
