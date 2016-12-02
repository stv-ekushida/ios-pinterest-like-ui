//
//  PhotoUsecase.swift
//  pinterest-like-ui
//
//  Created by Eiji Kushida on 2016/12/01.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

protocol PhotoListUsecase {
    func loadData()
}

final class PhotoListUsecaseImpl: PhotoListUsecase {

    var photoRepository: PhotoRepositoryImpl?
    
    init() {
        photoRepository = PhotoRepositoryImpl(delegate: self)
    }

    /// 写真データを読み出す
    func loadData() {
        photoRepository?.loadData()
    }
}

//MARK:- PhotoListDataDelegate
extension PhotoListUsecaseImpl: PhotoListDataDelegate {
    
    func done(_ photos: [Photo]) {
        PhotosLoadEvent.post(items: photos)
    }
    
    func noData() {
        //Do Somethig
    }
    
    func failure() {
        //Do Somethig        
    }
}
