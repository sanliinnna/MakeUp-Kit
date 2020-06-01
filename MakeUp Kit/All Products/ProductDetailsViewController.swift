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
    var colors: [Color]?
    var delegate: AddProductDelegat?

    //  MARK: Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var detailsView: UIView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var colorLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Product Details"
        
        scrollView.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self

//        navigationController?.navigationBar.prefersLargeTitles = false
//        let navigationBarAppearence = UINavigationBarAppearance()
//        navigationBarAppearence.shadowColor = .clear
//        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearence

        nameLabel.text = product?.name
        imageView.contentMode = .scaleAspectFill
        imageView.downloaded(from: (product?.imageLink)!)
        brandLabel.text = "Brand: \(product?.brand ?? "unknown")"
        typeLabel.text = "Type: \(product?.productType ?? "unknown")"
        priceLabel.text = "Price: $\(product?.price ?? "0")"
        descTextView.text = product?.description
        if !(product?.productColors.isEmpty)! {
            colorLabel.text = "Colors: "
            colors = product?.productColors
        } else {
            collectionView.isHidden = true
            colorLabel.isHidden = true
        }
        
        
        
    }
    
//    @IBAction func addToBag(_ sender: UIButton) {
//            DManager.share.saveProduct(name: productNameLabel.text)
//            delegate?.update()
//
//        }


}

extension ProductDetailsViewController: UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as! ColorCollectionViewCell
        let color = colors![indexPath.item]
        cell.nameLabel.text = color.colourName ?? "Default"
        cell.colorView.backgroundColor = UIColor(hexString: color.hexValue ?? "#000000")
        return cell
    }
    
    
}
