//
//  MyKitViewController.swift
//  MakeUp Kit
//
//  Created by Alina Huk on 30.05.2020.
//  Copyright © 2020 Alina Huk. All rights reserved.
//

import UIKit
import CoreData

class KitViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let vc = UIStoryboard(name: "ProductDetails", bundle: nil).instantiateViewController(identifier: "ProductDetailsVC") as! ProductDetailsViewController
    var refreshControl: UIRefreshControl!
    
    var products: [MyKitProduct]?
    
    var kitProducts: [MyKitProduct] = []

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
        
        if kitProducts.isEmpty {
            alert(section: "Kit", nav: self.navigationController!, vc: self)
        }

    }
    
    private func fetchData() {
        self.products = DBManager.share.products
    }
    
    func append() {
        for product in products! {
            if product.section == "Kit" {
                kitProducts.append(product)
            }
        }
    }
    
    func update() {
        self.kitProducts = []
        fetchData()
        append()
        tableView.reloadData()
    }
    
    @objc func didPullToRefresh() {
            update()
            refreshControl?.endRefreshing()
    }

}

extension KitViewController: UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, AddProductDelegat {
    
    // MARK: - Table view data sourse
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return kitProducts.count 
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let product = kitProducts[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "KitProductCell", for: indexPath) as! KitProductTableViewCell
            cell.nameLabel.text = product.name
            cell.brandLabel.text = product.brand
            cell.typeLabel.text = product.productType
            return cell
        }
        
        // MARK: - Table view data delegete
        
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
                
                let changeSection = changeSectionAction(at: indexPath)
                let delete = deleteAction(at: indexPath)
                return UISwipeActionsConfiguration(actions: [delete, changeSection])
                
            }
        
            func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
                let product = kitProducts[indexPath.row]
                let action = UIContextualAction(style: .destructive, title: "") { (action, view, completion) in
                    sendNotification(title: "Product was deleted", body: "5 seconds ago you deleted \(product.name!) from your Kit", interval: 5)
                    DBManager.share.delete(product: product)
                    self.kitProducts.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    completion(true)
                }
                action.backgroundColor = .red
                action.image = UIImage(systemName: "trash.fill")
                return action
            }
        
            func changeSectionAction(at indexPath: IndexPath) -> UIContextualAction {
                let product = kitProducts[indexPath.row]
                let action = UIContextualAction(style: .destructive, title: "") { (action, view, completion) in
                    sendNotification(title: "Product was moved", body: "5 seconds ago you moved \(product.name!) to your Kit", interval: 5)
                    DBManager.share.updateSection(product: product, section: "Wishlist")
                    self.kitProducts.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    completion(true)
                }
                action.backgroundColor = UIColor(hexString: "#FD77B7")
                action.image = UIImage(systemName: "heart")
                return action
            }
}
