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
    init(title: String, featuredImage: UIImage) {
        self.title = title
        self.featuredImage = featuredImage
    }
    
    static func fetchSections() -> [Section] {
        return [
            Section(title: "My Kit", featuredImage: UIImage(named: "cosm1")!),
            Section(title: "My Wishlist", featuredImage: UIImage(named: "cosm3")!)
        ]
    }
}
