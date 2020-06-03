//
//  WishlistViewController.swift
//  MakeUp Kit
//
//  Created by Alina Huk on 01.06.2020.
//  Copyright © 2020 Alina Huk. All rights reserved.
//

import UIKit
import CoreData

class WishlistViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let vc = UIStoryboard(name: "AllProducts", bundle: nil).instantiateViewController(identifier: "ProductDetailsVC") as! ProductDetailsViewController
    var refreshControl: UIRefreshControl!
    
    var products: [MyKitProduct]?
    
    var wishProducts: [MyKitProduct] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        append()
        tableView.dataSource = self
        tableView.delegate = self
        vc.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
        
        if wishProducts.isEmpty {
            alert()
        }
        

    }
    
    private func fetchData() {
        self.products = DManager.share.products
    }
    
    func update() {
        self.wishProducts = []
        fetchData()
        append()
        tableView.reloadData()
    }
    
    func append() {
        for product in products! {
            if product.section == "Wishlist" {
                wishProducts.append(product)
            }
        }
    }
    
    func alert() {
        let alert = UIAlertController(title: "Section is empty", message: "There is no product.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Go back", style: .default, handler: { (action) in
            print("M")
            alert.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    
    @objc func didPullToRefresh() {
            update()
            refreshControl?.endRefreshing()
    }


}

extension WishlistViewController: UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, AddProductDelegat {
    
    // MARK: - Table view data sourse
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return wishProducts.count 
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let product = wishProducts[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "KitProductCell", for: indexPath) as! KitProductTableViewCell
            cell.nameLabel.text = product.name
            cell.brandLabel.text = product.brand
            cell.typeLabel.text = product.productType
//            cell.imgView.contentMode = .scaleAspectFill
//            cell.imgView.downloaded(from: product.imageLink!)
            return cell
        }
        
        // MARK: - Table view data delegete
        
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let product = wishProducts[indexPath.row]
            let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
                DManager.share.delete(product: product)
                self.update()
            }
            action.backgroundColor = .red
            
            
            return UISwipeActionsConfiguration(actions: [action])
        }
    
}

