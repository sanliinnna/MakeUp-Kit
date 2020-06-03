//
//  ProductDetailsViewController.swift
//  MakeUp Kit
//
//  Created by Alina Huk on 31.05.2020.
//  Copyright © 2020 Alina Huk. All rights reserved.
//

import UIKit
import Foundation
import SafariServices
import CoreData

protocol AddProductDelegat {
    func update()
}

class ProductDetailsViewController: UIViewController {
    
    var product: Product?
    var colors: [Color]?
    var delegate: AddProductDelegat?
    var savedProducts: [MyKitProduct]?

    //  MARK: Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var addToKitButton: UIButton!
    @IBOutlet weak var addToWishlistButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var colorLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self

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
        
        buttonEnable()
        
//        addToKitButton.isEnabled = false
//        let checkExisting = DManager.share.checkExisting(newProduct: product!)
//        if !checkExisting {
//            addToKitButton.isEnabled = true
//        }
        
        
    }
    
    private func fetchData() {
        self.savedProducts = DManager.share.products
    }
    
    func checkExisting(button: UIButton, section: String) -> Bool {
        var flag = true
        for item in savedProducts! {
            if product?.name == item.name && item.section == section {
                print(item)
                flag = false
                return flag
            } else {
                flag = true
            }
        }
        return flag
    }
    
    func buttonEnable() {
        fetchData()
        addToKitButton.isEnabled = checkExisting(button: addToKitButton, section: "MyKit")
        addToWishlistButton.isEnabled = checkExisting(button: addToWishlistButton, section: "Wishlist")
    }
    
    func savedProduct() -> MyKitProduct {
        var saved: MyKitProduct?
        for item in savedProducts! {
            if product?.name == item.name {
                saved = item
            }
        }
        return saved!
    }
    
    
    func confirmation(addedTo: String, wantTo: String) {
        let alert = UIAlertController(title: "Warning!", message: "This product is already added to your \(addedTo). Add it to your \(wantTo)?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            DManager.share.saveProduct(id: (self.product?.id)!, name: self.product?.name, brand: self.product?.brand, type: self.product?.productType, price: self.product?.price, imageLink: self.product?.imageLink, productLink: self.product?.productLink, description: self.product?.description, section: "\(wantTo)")
            self.delegate?.update()
            self.buttonEnable()
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Delete & Add", style: .destructive, handler: { (action) in
            self.savedProduct()
            DManager.share.updateSection(product: self.savedProduct(), section: "\(wantTo)")
            self.delegate?.update()
            self.buttonEnable()
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true)
    }
    
    
    @IBAction func addToMyKit(_ sender: UIButton) {
        if addToWishlistButton.isEnabled == false {
            confirmation(addedTo: "Wishlist", wantTo: "MyKit")
        } else {
            DManager.share.saveProduct(id: (self.product?.id)!, name: self.product?.name, brand: self.product?.brand, type: self.product?.productType, price: self.product?.price, imageLink: self.product?.imageLink, productLink: self.product?.productLink, description: self.product?.description, section: "MyKit")
            self.delegate?.update()
            self.buttonEnable()
        }
    }
    @IBAction func addToWishlist(_ sender: UIButton) {
        if addToKitButton.isEnabled == false {
        confirmation(addedTo: "MyKit", wantTo: "Wishlist")
        } else {
            DManager.share.saveProduct(id: (self.product?.id)!, name: self.product?.name, brand: self.product?.brand, type: self.product?.productType, price: self.product?.price, imageLink: self.product?.imageLink, productLink: self.product?.productLink, description: self.product?.description, section: "Wishlist")
            self.delegate?.update()
            self.buttonEnable()
        }
        
    }
    
    
    @IBAction func openProductPage(_ sender: UIButton) {
        showSafariVC(for: (self.product?.productLink)!)
    }
    
    func showSafariVC(for url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    
    
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
