//
//  ResponseButton.swift
//  Response
//
//  Created by Elmer Astudillo on 2/24/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit

class ResponseButton: UIButton {

    // MARK: - INITIALIZATION
    
    init(frame: CGRect, backgroundColor: UIColor, title: String){
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
        
        titleLabel?.font = ._10ProximaBold
        
        setTitle(title, for: .normal)
        setTitle(title, for: .highlighted)

        setTitleColor(.white, for: .normal)
        setTitleColor(.white, for: .highlighted)
        
        clipsToBounds = true
    }
    
    convenience init(frame: CGRect, backgroundColor: UIColor, title: String, image: UIImage, inset: CGFloat){
        self.init(frame: frame, backgroundColor: backgroundColor, title: title)
        
        setImage(image, for: .normal)
        setImage(image, for: .highlighted)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let negativeInset = inset * -1
        let doubleInset = inset * 2
        
        titleEdgeInsets = UIEdgeInsetsMake(0, inset, 0, negativeInset)
        contentHorizontalAlignment = .center
        contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, doubleInset)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LAYOUT
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 17.5
        self.layer.masksToBounds = true
    }
}
