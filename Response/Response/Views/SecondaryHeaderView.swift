//
//  SecondaryHeaderView.swift
//  Response
//
//  Created by Elmer Astudillo on 3/24/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import UIKit

class SecondaryHeaderView: UITableViewHeaderFooterView {
    
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
        sectionHeaderLabel.font = ._22ProximaBold
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
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(27)
        }
    }
}
