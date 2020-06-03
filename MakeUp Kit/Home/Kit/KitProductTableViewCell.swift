//
//  KitProductTableViewCell.swift
//  MakeUp Kit
//
//  Created by Alina Huk on 01.06.2020.
//  Copyright © 2020 Alina Huk. All rights reserved.
//

import UIKit

class KitProductTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
