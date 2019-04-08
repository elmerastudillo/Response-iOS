//
//  OrganizationButton.swift
//  Response
//
//  Created by Keivan Shahida on 8/8/17.
//  Copyright © 2017 Keivan Shahida. All rights reserved.
//

import UIKit
import SnapKit

class OrganizationButton: UIButton {

    // MARK: - INITIALIZATION
    var backgroundImageView = UIImageView()
    
    init(frame: CGRect, color: UIColor, text: String) {
        super.init(frame: frame)
        backgroundColor = color
        titleLabel?.font = ._16ProximaBold
        titleLabel?.textColor = .white
        setTitle(text, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LAYOUT
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true

    }
    
    init(frame: CGRect, organizationImage: UIImage){
        super.init(frame: frame)
        backgroundColor = .responseBlue
        clipsToBounds = true
        backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35.0, height: 35.0))
        backgroundImageView.image = organizationImage
        backgroundImageView.contentMode = .scaleAspectFit
        addSubview(backgroundImageView)
        setConstaints()
    }
    
    // MARK: - CONSTRAINTS
    func setConstaints() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(35.0)
            make.height.equalTo(35.0)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
        }
    }
}
