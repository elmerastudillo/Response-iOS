//
//  OrganizationRoundCell.swift
//  Response
//
//  Created by Elmer Astudillo on 2/27/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit

class OrganizationIconCell: UICollectionViewCell {
    
    //MARK: - INITIALIZATION
    var imageView = UIImageView()
    var organization: Organization?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LAYOUT
    override func layoutSubviews() {
        imageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 80, height: 80))
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "unicef-logo-square")
        imageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(imageView)
    }
}
