//
//  ListCollectionVC.swift
//  Eurotech
//
//  Created by Артем Карпов on 10.07.17.
//  Copyright © 2017 Артем Карпов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

private let reuseIdentifier = "Cell"

class GoodsCollectionVC: UICollectionViewController {
    
    var item: Menu?
    var goods: [Unit] = []
    
    convenience init(_ item: Menu?) {
        self.init()
        self.item = item
        print(item?.title as Any)
        print(item?.link as Any)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(item?.title as Any)
        //print(item?.link as Any)
        
        let url:String = (item?.link)!
        //let url = "http://shop.eurotechservice.ru/catalog/iphone_4_s/?json=Y&PAGE_COUNT=1000"
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print(json.arrayValue)
                let result = json.arrayValue.flatMap({ (object) -> Unit? in
                    return Unit.makeUnit(fromDictionary: object.dictionaryObject)
                })
                self.goods = result
                //print(self.goods)
                self.collectionView?.reloadData()
            case .failure(let error):
                print(error)
            }
        }


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register 
        //self.collectionView!.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        //self.collectionView!.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return goods.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
        
        let product = goods[indexPath.row]
        cell.product = product
        
        // Configure the cell
        cell.nameLabel.text = product.name
//        let string = "http://shop.eurotechservice.ru" + (goods[indexPath.row].images[indexPath.row]["path"] as? String)!
//        let url = URL(string: string)
//        let data = try? Data(contentsOf: url!)
//        
//        if let imageData = data {
//            let image = UIImage(data: imageData)
//            cell.productPhoto.image = image
//        }
        //cell.nameLabel.text = goods[indexPath.row].images[0]["path"] as? String
        
        //cell.backgroundColor = .random()
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
