//
//  Menu.swift
//  Eurotech
//
//  Created by Артем Карпов on 11.07.17.
//  Copyright © 2017 Артем Карпов. All rights reserved.
//

import UIKit

class Menu: NSObject {
    
    let title: String
    let link: String
    let subMenu: [Menu]?
    
    init(title: String, link: String, subMenu: [Menu]? = nil) {
        self.title = title
        self.link = link
        self.subMenu = subMenu
    }
}

extension Menu {
    class func makeMenu(fromDictionary dic: [String: Any]?) -> Menu? {
        guard
            let dic = dic,
            let title = dic["title"] as? String,
            let link = dic["link"] as? String
        else {
            return nil
        }
   
 
        let subMenuDict = dic["subMenu"] as? [[String: Any]]
        
        let subMenu =  subMenuDict?.flatMap({ (dict) -> Menu? in
            return Menu.makeMenu(fromDictionary: dict)
        })
        /*
        item.subMenu?.flatMap({ (object) -> Menu? in
            return Menu.makeSubMenu(fromDictionary: object)
        })
 */
        //print(subMenu as Any)
//        for object in subMenu {
//            print(object)
//        }
        
        return Menu(title: title, link: link, subMenu: subMenu)
    }
    /*
    class func makeSubMenu(fromDictionary dic: [String: Any]?) -> Menu? {
        guard
            let dic = dic,
            let title = dic["title"] as? String,
            let link = dic["link"] as? String
            else {
                return nil
        }
                
        return Menu(title: title, link: link)
    }
*/
}



