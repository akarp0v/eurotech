//
//  Unit.swift
//  Eurotech
//
//  Created by Артем Карпов on 13.07.17.
//  Copyright © 2017 Артем Карпов. All rights reserved.
//

import Foundation


class Unit: NSObject {
    
//    let title : String
    let name  : String
//    let alt   : String
//    let path  : String
    let descr : String
//    let OSTATOK_KHIMIKOV: Float
//    let OSTATOK_ZHUKOVA : Float
    let article         : String
//    let price           : Float
//    let old_price       : Float
//    let images:[[String: Any]]
    let imagesUrls:[String]
    
    init(name: String, descr: String, article: String, imagesUrls:[String]) {
        self.name    = name
//        self.title   = title
//        self.path    = path
        self.descr   = descr
        self.article = article
//        self.images  = images
        self.imagesUrls = imagesUrls
    }
}

extension Unit {
    class func makeUnit(fromDictionary dic: [String: Any]?) -> Unit? {
        guard
            let dic = dic,
            let name  = dic["name"] as? String,
//            let title = dic["title"] as? String,
//            let path  = dic["path"] as? String,
            let descr = dic["descr"] as? String,
            let article  = dic["article"] as? String
            else {
                return nil
        }
        
        var imagesUrls: [String] = []
        let images = dic["images"] as? [[String: Any]]
        for obj in images! {
            imagesUrls.insert((obj["path"] as? String)!, at: 0)
        }
        //let imagesUrls = images.map{$0["path"]} as? [String]
        return Unit(name: name, descr: descr, article: article, imagesUrls: imagesUrls)
    }
}
