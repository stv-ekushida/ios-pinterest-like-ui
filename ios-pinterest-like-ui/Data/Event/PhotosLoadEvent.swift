//
//  PhotosLoadEvent.swift
//  pinterest-like-ui
//
//  Created by Kushida　Eiji on 2016/12/02.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

protocol CallBackEventType {
    
    static var eventKey:String { get }
    static var userInfoKey: String { get }
    
    static func add(_ observer: Any, _ selector: Selector)
    static func post(items: [Any])
    static func parse(userInfo:  [AnyHashable : Any]?) -> [Any]
}

final class PhotosLoadEvent: CallBackEventType {
    
    static let eventKey = "didLoadData"
    static let userInfoKey = "loadData"
    
    static func add(_ observer: Any, _ selector: Selector) {

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(observer,
                       selector: selector,
                       name: Notification.Name(rawValue:eventKey),
                       object: nil)
        
    }
    
    static func post(items: [Any]) {

        let notificationCenter = NotificationCenter.default
        notificationCenter.post(name: Notification.Name(rawValue:eventKey),
                                object: nil,
                                userInfo: [userInfoKey : items])
    }
    
    static func parse(userInfo:  [AnyHashable : Any]?) -> [Any] {

        remove()
        return userInfo?[userInfoKey] as! [Any]
    }
    
    static func remove() {
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
}
