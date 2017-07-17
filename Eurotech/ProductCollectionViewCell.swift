//
//  ProductCollectionViewCell.swift
//  Eurotech
//
//  Created by Артем Карпов on 16.07.17.
//  Copyright © 2017 Артем Карпов. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productPhoto: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var product: Unit? {
        didSet {
            let url = URL(string: (product?.imagesUrls.first)!)
            productPhoto.kf.setImage(with: url)
        }
    }
}
