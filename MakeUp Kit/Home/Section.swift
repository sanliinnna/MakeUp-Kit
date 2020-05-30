//
//  Section.swift
//  MakeUp Kit
//
//  Created by Alina Huk on 30.05.2020.
//  Copyright © 2020 Alina Huk. All rights reserved.
//

import UIKit

class Section {
    var title = ""
    var featuredImage: UIImage
    var color: UIColor
//    var featuredIcon: UIImage
    init(title: String, featuredImage: UIImage, color: UIColor) {
        self.title = title
        self.featuredImage = featuredImage
        self.color = color
//        self.featuredIcon = featuredIcon
    }
    
    static func fetchSections() -> [Section] {
        return [
            Section(title: "My Kit", featuredImage: UIImage(named: "cosm1")!, color: UIColor(red: 102/225, green: 30/225, blue: 50/225, alpha: 0)),
            Section(title: "My Wishlist", featuredImage: UIImage(named: "cosm3")!, color: UIColor(red: 102/225, green: 30/225, blue: 50/225, alpha: 0))
        ]
    }
}
