//
//  RoundedRectangleButton.swift
//  Response
//
//  Created by Keivan Shahida on 10/6/17.
//  Copyright © 2017 Keivan Shahida. All rights reserved.
//

import UIKit
import UIImageColors

class RoundedRectangleButton: UIButton {
    
    // MARK: - INITIALIZATION
    init(frame: CGRect, text: String, normalBackgroundColor: UIColor, highlightedBackgroundColor: UIColor, normalTextColor: UIColor, highlightedTextColor: UIColor) {
        super.init(frame: frame)
        
        backgroundColor = normalBackgroundColor
        setBackgroundColor(color: highlightedBackgroundColor, forState: .highlighted)

        layer.cornerRadius = 8
        clipsToBounds = true
        
        setTitle(text, for: .normal)
        setTitleColor(normalTextColor, for: .normal)
        setTitleColor(highlightedTextColor, for: .highlighted)
        
        titleLabel?.font = ._18ProximaSemibold
    }
    
    convenience init(frame: CGRect, text: String, backgroundColor: UIColor, textColor: UIColor) {
        self.init(frame: frame, text: text, normalBackgroundColor: backgroundColor, highlightedBackgroundColor: backgroundColor, normalTextColor: textColor, highlightedTextColor: textColor)
    }
    
    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        
        image.getColors() { colors in
            self.backgroundColor = colors.background
            self.setBackgroundColor(color: self.backgroundColor!, forState: .highlighted)
        }
        
        layer.cornerRadius = 8
        clipsToBounds = true
        
        contentMode = .scaleAspectFit
        setImage(image, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
}
