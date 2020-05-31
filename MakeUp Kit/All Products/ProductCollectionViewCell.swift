//
//  ProductCollectionViewCell.swift
//  MakeUp Kit
//
//  Created by Alina Huk on 31.05.2020.
//  Copyright © 2020 Alina Huk. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        imageView.layer.cornerRadius = 10
//        imageView.layer.masksToBounds = true
//        self.layer.cornerRadius = 10
//        self.layer.shadowRadius = 8
//        self.layer.shadowOpacity = 0.2
//        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        
//        self.clipsToBounds = false
    }
}
