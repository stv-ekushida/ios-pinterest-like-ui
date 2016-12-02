//
//  PhotoDataSource.swift
//  pinterest-like-ui
//
//  Created by Kushida　Eiji on 2016/12/02.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class PhotoDataSource {

    static let fileName = "photos"
    static let fileType = "plist"

    static func plist() -> [Photo] {
        
        var result = [Photo]()

        guard let filePath =  Bundle.main.path(forResource: fileName, ofType: fileType) else {
            return result
        }
        
        guard let contentsOfFile = NSDictionary(contentsOfFile: filePath) else {
            return result
        }
        
        let photos = contentsOfFile.object(forKey: "photos") as! NSArray
        
        photos.forEach {

            guard let dic = $0 as? NSDictionary else {
                return
            }

            var photo = Photo()
            photo.caption = dic.object(forKey: "caption") as? String ?? ""
            photo.comment = dic.object(forKey: "comment") as? String ?? ""
            photo.image = UIImage(named: dic.object(forKey: "image") as? String ?? "")
            result.append(photo)
        }
        return result
    }
}
