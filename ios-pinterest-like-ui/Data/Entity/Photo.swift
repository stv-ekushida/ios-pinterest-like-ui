//
//  Photo.swift
//  pinterest-like-ui
//
//  Created by Kushida　Eiji on 2016/12/02.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

struct Photo {
    var caption = ""
    var comment = ""
    var image: UIImage?
    
    func heightForCaption(_ font: UIFont, width: CGFloat) -> CGFloat {
        
        let rect = NSString(string: caption).boundingRect(
            with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
            options: .usesLineFragmentOrigin,
            attributes: [NSFontAttributeName: font], context: nil)
        
        return ceil(rect.height)
    }
        
    func heightForComment(_ font: UIFont, width: CGFloat) -> CGFloat {
        
        let rect = NSString(string: comment).boundingRect(
            with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
            options: .usesLineFragmentOrigin,
            attributes: [NSFontAttributeName: font], context: nil)
        
        return ceil(rect.height)
    }
}
