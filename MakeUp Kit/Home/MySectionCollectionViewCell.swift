//
//  MySectionCollectionViewCell.swift
//  MakeUp Kit
//
//  Created by Alina Huk on 30.05.2020.
//  Copyright © 2020 Alina Huk. All rights reserved.
//

import UIKit

class MySectionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var section: Section! {
        didSet {
            self.update()
        }
    }
    
    func update() {
        if let section = section {
            titleLabel.text = section.title
            featuredImageView.image = section.featuredImage
            backgroundColorView.backgroundColor = section.color
        } else {
            titleLabel.text = nil
            featuredImageView.image = nil
            backgroundColorView.backgroundColor = nil
        }
        
        featuredImageView.layer.cornerRadius = 10
        featuredImageView.layer.masksToBounds = true
        
        backgroundColorView.layer.cornerRadius = 10
        backgroundColorView.layer.masksToBounds = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 1, height: 5)
        
        self.clipsToBounds = false
    }
    
    
}
