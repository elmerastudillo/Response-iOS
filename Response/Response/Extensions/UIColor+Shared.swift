//
//  UIColor+Shared.swift
//  Response
//
//  Created by Keivan Shahida on 7/29/17.
//  Copyright © 2017 Keivan Shahida. All rights reserved.
//

import UIKit

extension UIColor {
    //    UIColor.colorFromCode(0xA23A40).withAlphaComponent(0.26)
    
    @nonobjc static let responseOffWhite = UIColor.colorFromCode(0xBEBEBE)
    @nonobjc static let responseBlack = UIColor.colorFromCode(0x131313)
    @nonobjc static let responseDarkGrey = UIColor.colorFromCode(0x1D1D1D)
    @nonobjc static let responseLightGrey = UIColor.colorFromCode(0xf2f2f2).withAlphaComponent(0.2)
    
    @nonobjc static let responseRed = UIColor.colorFromCode(0xFA2264)
    @nonobjc static let responseBrightRed = UIColor.colorFromCode(0xFE2851)
    @nonobjc static let responseDarkRed = UIColor.colorFromCode(0x850034)
    
    @nonobjc static let responseBlue = UIColor.colorFromCode(0x01AEF0)
    @nonobjc static let responseDarkBlue = UIColor.colorFromCode(0x0182B3)
    

    public static func colorFromCode(_ code: Int) -> UIColor {
        let red = CGFloat(((code & 0xFF0000) >> 16)) / 255
        let green = CGFloat(((code & 0xFF00) >> 8)) / 255
        let blue = CGFloat((code & 0xFF)) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
