//
//  PhotoRepository.swift
//  pinterest-like-ui
//
//  Created by Eiji Kushida on 2016/12/01.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

protocol PhotoListRepository {
    func loadData()
}

protocol PhotoListDataDelegate {
    func done(_: [Photo])
    func noData()
    func failure()
}

final class PhotoRepositoryImpl: PhotoListRepository {
    
    var delegate: PhotoListDataDelegate?
    
    init(delegate: PhotoListDataDelegate) {
        self.delegate = delegate
    }

    func loadData() {
        
        let photos = PhotoDataSource.plist()
        if photos.count == 0 {
            delegate?.noData()
            return
        }        
        delegate?.done(photos)
    }
}
