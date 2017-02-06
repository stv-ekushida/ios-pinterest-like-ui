//
//  PinterestLayout.swift
//  pinterest-like-ui
//
//  Created by Kushida　Eiji on 2016/12/02.
//  Copyright © 2016年 Kushida　Eiji. All rights reserved.
//

import UIKit

protocol PinterestLayoutDelegate {
    
    //画像の高さを返す
    func collectionView(_ collectionView:UICollectionView,
                        heightForPhotoAtIndexPath indexPath:IndexPath ,
                        withWidth:CGFloat) -> CGFloat
    
    //キャプションとコメントの高さを返す
    func collectionView(_ collectionView: UICollectionView,
                        heightForCaptionAndCommentAtIndexPath indexPath: IndexPath,
                        withWidth width: CGFloat) -> CGFloat
}

class PinterestLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var photoHeight = CGFloat(0.0)
    
    override func copy(with zone: NSZone?) -> Any {
        
        let copy = super.copy(with: zone) as! PinterestLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        
        if let attributes = object as? PinterestLayoutAttributes {
            
            if attributes.photoHeight == photoHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
}

class PinterestLayout: UICollectionViewLayout {
    
    var delegate: PinterestLayoutDelegate?
    
    //カラム数
    var numberOfColumns = 2
    var cellPadding = CGFloat(8.0)
    
    var cache = [PinterestLayoutAttributes]()
    
    var contentHeight = CGFloat(0.0)
    var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    
    override class var layoutAttributesClass : AnyClass {
        return PinterestLayoutAttributes.self
    }
    
    //MARK:- Layout LifeCycle
    
    /**
     1. レイアウトの事前計算を行う
     */
    override func prepare() {
        super.prepare()
        
        guard cache.isEmpty else{
            return
        }
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
            
            
            let indexPath = IndexPath(item: item, section: 0)
            
            let width = columnWidth - cellPadding * 2
            let photoHeight = delegate!.collectionView(collectionView!,
                                                       heightForPhotoAtIndexPath: indexPath,
                                                       withWidth: width)
            let labelHeight = delegate!.collectionView(collectionView!,
                                                       heightForCaptionAndCommentAtIndexPath: indexPath,
                                                       withWidth: width)
            
            let height = cellPadding + photoHeight + labelHeight
            
            let frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: columnWidth,
                               height: height)
            
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = PinterestLayoutAttributes(forCellWith: indexPath)
            
            attributes.photoHeight = photoHeight
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            if column >= numberOfColumns - 1 {
                column = 0
            } else {
                column += 1
            }
        }
    }
    
    /**
     2. コンテンツのサイズを返す
     */
    override var collectionViewContentSize : CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    /**
     3. 表示する要素を返す
     */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}

