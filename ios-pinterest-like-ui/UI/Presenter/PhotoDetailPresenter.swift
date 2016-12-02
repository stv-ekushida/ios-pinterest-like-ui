//
//  PhotoDetailPresenter.swift
//  pinterest-like-ui
//
//  Created by Eiji Kushida on 2016/12/02.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

protocol PhotoDetailDelegate {
    func updateThumnail(image: UIImage?)
}

final class PhotoDetailPresenter: NSObject {

    var delegate: PhotoDetailDelegate?

    init(delegate: PhotoDetailDelegate) {
        self.delegate = delegate
    }

    func configureThumnail(photo: Photo?){
        self.delegate?.updateThumnail(image: photo?.image)
    }
}
