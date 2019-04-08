//
//  PrimaryHeaderView.swift
//  Response
//
//  Created by Keivan Shahida on 7/20/17.
//  Copyright © 2017 Keivan Shahida. All rights reserved.
//

import UIKit
import SnapKit

class PrimaryHeaderView: UITableViewHeaderFooterView {
    
    var title: String = "" {
        didSet {
            sectionHeaderLabel.text = title
        }
    }
    
    var sectionHeaderLabel = UILabel()
    
    // MARK: - INITIALIZATION
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.layer.backgroundColor = UIColor.responseBlack.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LAYOUT
    override func layoutSubviews() {
        sectionHeaderLabel.textColor = .white
        sectionHeaderLabel.font = UIFont(name: "ProximaNova-Bold", size: 36.0)
        sectionHeaderLabel.textAlignment = NSTextAlignment.left
        sectionHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sectionHeaderLabel)
        
        setConstraints()
    }
    
    // MARK: - CONSTRAINTS
    func setConstraints(){
        sectionHeaderLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(30)
            make.width.equalTo(180)
            make.height.equalTo(44)
        }
    }
}
