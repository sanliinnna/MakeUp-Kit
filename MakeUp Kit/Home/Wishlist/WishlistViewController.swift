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
    
    let vc = UIStoryboard(name: "ProductDetails", bundle: nil).instantiateViewController(identifier: "ProductDetailsVC") as! ProductDetailsViewController
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
            alert(section: "Wishlist", nav: self.navigationController!, vc: self)
        }
    }
    
    private func fetchData() {
        self.products = DBManager.share.products
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
    
    @objc func didPullToRefresh() {
            update()
            refreshControl?.endRefreshing()
    }
}

extension WishlistViewController: UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, AddProductDelegat {
    
    // MARK: - Table View Data Sourse
        
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
        
        // MARK: - Table View Data Delegete
    
        internal func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
            let product = wishProducts[indexPath.row]
               let alert = UIAlertController(title: "Go to website", message: "Go to product website to see more information.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action) in
                   alert.dismiss(animated: true, completion: nil)
                }))
                alert.addAction(UIAlertAction(title: "Go", style: .default, handler: { (action) in
                   alert.dismiss(animated: true, completion: nil)
                    UIApplication.shared.open(URL(string: product.productLink!)!)
                }))
               self.present(alert, animated: true)
        }
        
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            let changeSection = changeSectionAction(at: indexPath)
            let delete = deleteAction(at: indexPath)
            return UISwipeActionsConfiguration(actions: [delete, changeSection])
            
        }
    
        func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
            let product = wishProducts[indexPath.row]
            let action = UIContextualAction(style: .destructive, title: "") { (action, view, completion) in
                sendNotification(title: "Product was deleted", body: "5 seconds ago you deleted \(product.name!) from your Wishlist", interval: 5)
                DBManager.share.delete(product: product)
                self.wishProducts.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                completion(true)
            }
            action.backgroundColor = .red
            action.image = UIImage(systemName: "trash.fill")
            return action
        }
    
        func changeSectionAction(at indexPath: IndexPath) -> UIContextualAction {
            let product = wishProducts[indexPath.row]
            let action = UIContextualAction(style: .destructive, title: "") { (action, view, completion) in
                sendNotification(title: "Product was moved", body: "5 seconds ago you moved \(product.name!) to your Kit", interval: 5)
                DBManager.share.updateSection(product: product, section: "Kit")
                self.wishProducts.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                completion(true)
            }
            action.backgroundColor = UIColor(hexString: "#FFD100")
            action.image = UIImage(systemName: "star")
            return action
        }
}

