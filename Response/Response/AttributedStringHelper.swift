//
//  AttributedStringHelper.swift
//  Response
//
//  Created by Elmer Astudillo on 3/5/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import Foundation
import UIKit

struct AttributedStringHelper
{
    // String with image
    static func attributedStringWithImage(text: String, image: UIImage) -> NSAttributedString
    {
        // create an NSMutableAttributedString that we'll append everything to
        let fullString = NSMutableAttributedString(string: "")
        
        //wrap the attachment in its own attributed string so we can apppend it
        let imageString = NSAttributedString(attachment: textAttachment(image: image, fontSize: 10.0))
        
        // Setting color for attributed string by setting the foreground color key
        let attribute = [NSAttributedStringKey.foregroundColor : UIColor.white]
        // Setting alignment
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let alignmentAttribute : [NSAttributedStringKey : Any] = [NSAttributedStringKey.paragraphStyle : paragraph]
        
        //add the NSTextAttachment wrapper to our full string, then add some more text.
        fullString.append(imageString)
        fullString.append(NSAttributedString(string: text, attributes: attribute))
        fullString.addAttributes(alignmentAttribute, range: NSRange(location: 0, length: fullString.length))
        
        return fullString
    }
    
    static func textAttachment(image: UIImage,fontSize: CGFloat) -> NSTextAttachment {
        let font = UIFont.systemFont(ofSize: fontSize) //set accordingly to your font, you might pass it in the function
        let textAttachment = NSTextAttachment()
        textAttachment.image = image
        textAttachment.bounds = CGRect(x: 0, y: (font.capHeight - image.size.height).rounded() / 2, width: image.size.width, height: image.size.height)
        return textAttachment
    }
    
    // String with custom line spacing
    static func attributedStringWithLineSpacing(text: String, lineSpacing: CGFloat, lineHeightMultiple: CGFloat) -> NSAttributedString
    {
        let attributedString = NSMutableAttributedString(string:text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.minimumLineHeight = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
}
