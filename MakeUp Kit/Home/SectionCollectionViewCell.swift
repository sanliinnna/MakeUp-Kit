//
//  MySectionCollectionViewCell.swift
//  MakeUp Kit
//
//  Created by Alina Huk on 30.05.2020.
//  Copyright © 2020 Alina Huk. All rights reserved.
//

import UIKit

class SectionCollectionViewCell: UICollectionViewCell {
    
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
        } else {
            titleLabel.text = nil
            featuredImageView.image = nil
        }
        
    }
    
}
