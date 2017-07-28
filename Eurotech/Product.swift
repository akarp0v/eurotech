//
//  Unit.swift
//  Eurotech
//
//  Created by Артем Карпов on 13.07.17.
//  Copyright © 2017 Артем Карпов. All rights reserved.
//

import Foundation
import RealmSwift

class Product: NSObject {
    
//    let title : Stvarg
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
    let imagesArray:[ProductImages]?
    
    init(name: String, descr: String, article: String, imagesArray:[ProductImages]? = nil) {
        self.name    = name
//        self.title   = title
//        self.path    = path
        self.descr   = descr
        self.article = article
//        self.images  = images
        self.imagesArray = imagesArray
    }
}

extension Product {
    class func makeProduct(fromDictionary dic: [String: Any]?) -> Product? {
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
        var array = [ProductImages]()
        var image = ProductImages()
        let images = dic["images"] as? [[String: Any]]
        for obj in images! {
            image.title = (obj["title"] as? String)!
            image.alt   = (obj["alt"] as? String)!
            image.path  = (obj["path"] as? String)!
            array.append(image)
        }
        
        //let imagesUrls = images.map{$0["path"]} as? [String]
        return Product(name: name, descr: descr, article: article, imagesArray: array)
    }
}
