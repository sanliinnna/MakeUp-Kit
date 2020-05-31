//
//  ProductDetailsViewController.swift
//  MakeUp Kit
//
//  Created by Alina Huk on 31.05.2020.
//  Copyright © 2020 Alina Huk. All rights reserved.
//

import UIKit
import Foundation

protocol AddProductDelegat {
    func update()
}

class ProductDetailsViewController: UIViewController {
    
    var product: Product?
    var delegate: AddProductDelegat?

    //  MARK: Outlets
    
//    @IBOutlet weak var productNameLabel: UILabel!
//    @IBOutlet weak var productImageView: UIImageView!
//    @IBOutlet weak var goBackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = product?.name
        navigationController?.navigationBar.prefersLargeTitles = false

//        productNameLabel.text = product?.name
//        productImageView.contentMode = .scaleAspectFill
//        productImageView.downloaded(from: (product?.imageLink)!)
        
        
    }
    
//    @IBAction func addToBag(_ sender: UIButton) {
//            DManager.share.saveProduct(name: productNameLabel.text)
//            delegate?.update()
//
//        }


}
