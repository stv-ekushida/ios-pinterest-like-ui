//
//  PhotoListPresenter.swift
//  pinterest-like-ui
//
//  Created by Eiji Kushida on 2016/12/01.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class PhotoListPresenter: NSObject {

    var usecase: PhotoListUsecase?

    init(usecase: PhotoListUsecase) {
        super.init()
        self.usecase = usecase
    }

    func loadPhotos() {
        usecase?.loadData()
    }

    func showDetail(photo: Photo, topOf: UIViewController) {

        let vc = createVC() as! PhotoDetailViewController
        setupParam(vc: vc, param: photo)
        topOf.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PhotoListPresenter: ViewControllerType {

    func createVC() -> UIViewController? {

        return UIStoryboard.getViewController(storyboardName: "PhotoDetail",
                                              identifier: PhotoDetailViewController.identifier)
    }

    func setupParam(vc: UIViewController, param: Any) {
        (vc as! PhotoDetailViewController).photo = param as? Photo
    }
}
