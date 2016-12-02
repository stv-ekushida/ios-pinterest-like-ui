//
//  PhotoListViewController.swift
//  pinterest-like-ui
//
//  Created by Eiji Kushida on 2016/12/01.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit
import AVFoundation

final class PhotoListViewController: UIViewController {

    @IBOutlet weak var photoListCollectionView: UICollectionView!
    var presenter: PhotoListPresenter?
    var photoListDataSource = PhotoListCollectionView()
    var photos: [Photo] = []
    
    //MARK:- Method Level1
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPhotos()
    }

    //データの読み込み完了
    func didLoadPhotos(notification: Notification) {
        
        photos = PhotosLoadEvent.parse(userInfo: notification.userInfo) as! [Photo]
        photoListDataSource.modify(photos: photos)
        photoListCollectionView.reloadData()
    }

    //MARK:- Private Method Level2
    fileprivate func setup() {
        setupPhotoListView()
        setupPresenter()
        addCallBackEvent()
    }

    fileprivate func loadPhotos() {
        presenter?.loadPhotos()
    }

    fileprivate func didShowDetail(indexPath: IndexPath) {
        presenter?.showDetail(photo: photos[indexPath.row], topOf: self)
    }

    //MARK:- Private Method Level3
    fileprivate func setupPhotoListView() {
        
        photoListCollectionView.backgroundColor = UIColor.clear
        photoListCollectionView.dataSource = photoListDataSource
        photoListCollectionView.delegate = self
        
        if let layout = photoListCollectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
    }

    fileprivate func setupPresenter() {
        presenter = PhotoListPresenter(usecase: PhotoListUsecaseImpl())
    }

    fileprivate func addCallBackEvent() {
        PhotosLoadEvent.add(self, #selector(self.didLoadPhotos))
    }
}

//MARK:- UICollectionViewDelegate
extension PhotoListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didShowDetail(indexPath: indexPath)
    }
}

//MARK:- PinterestLayoutDelegate
extension PhotoListViewController: PinterestLayoutDelegate {
    
    func collectionView(_ collectionView:UICollectionView,
                        heightForPhotoAtIndexPath indexPath:IndexPath ,
                        withWidth width:CGFloat) -> CGFloat {
        
        let photo = photos[indexPath.row]
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: photo.image!.size, insideRect: boundingRect)
        return rect.size.height
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        heightForCaptionAndCommentAtIndexPath indexPath: IndexPath,
                        withWidth width: CGFloat) -> CGFloat {
        
        let photo = photos[(indexPath as NSIndexPath).item]
        
        let padding = CGFloat(16)
        let captionrHeight = photo.heightForCaption(UIFont.systemFont(ofSize: 13), width: width)
        let commentHeight = photo.heightForComment(UIFont.systemFont(ofSize: 11), width: width)
        
        let height = padding + captionrHeight + commentHeight + padding
        return height
    }
}

