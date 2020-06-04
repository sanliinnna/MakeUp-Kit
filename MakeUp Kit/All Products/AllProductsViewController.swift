//
//  AllProductsViewController.swift
//  MakeUp Kit
//
//  Created by Alina Huk on 31.05.2020.
//  Copyright © 2020 Alina Huk. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class AllProductsViewController: UIViewController {
    
//    MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
//    MARK: - Variables & Constants
    
    var allProducts = [Product]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.loading.stopAnimating()
            }
        }
    }
    var tempProducts = [Product]()
    
    let loading = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: .black, padding: 0)
    let searchController = UISearchController(searchResultsController: nil)
    
//    MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startAnimation()
        
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        ProductRequest().getProducts { result  in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let products):
                print("No error found.")
                self.allProducts = products
                self.tempProducts = products
            }
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
//    MARK: - Functions & Actions
    
    fileprivate func startAnimation() {
        loading.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loading)
        NSLayoutConstraint.activate([
            loading.widthAnchor.constraint(equalToConstant: 40),
            loading.heightAnchor.constraint(equalToConstant: 40),
            loading.centerXAnchor.constraint(equalTo: self.collectionView.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: self.collectionView.centerYAnchor)
        ])
        loading.startAnimating()
    }

    @IBAction func reloadProducts(_ sender: UIBarButtonItem) {
        startAnimation()
        self.allProducts = self.tempProducts
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.loading.stopAnimating()
        }
    }
    
}

//    MARK: -

extension AllProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
//    MARK: - Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allProducts.count
    }
            
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        let product = allProducts[indexPath.item]
        cell.textLabel.text = product.name
        cell.imageView.contentMode = .scaleAspectFill
        DispatchQueue.main.async() {
            cell.imageView.downloaded(from: product.imageLink!)
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "searchBar", for: indexPath)
        return searchView
        
    }
    
//    MARK: - Collection View Delegate
            
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "ProductDetails", bundle: nil).instantiateViewController(identifier: "ProductDetailsVC") as! ProductDetailsViewController
        let product = allProducts[indexPath.item]
        vc.product = product
        navigationController?.pushViewController(vc, animated: true)


    }
    
//    MARK: - Search Bar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.allProducts.removeAll()
        for item in self.tempProducts {
            if (item.name?.lowercased().contains(searchText.lowercased()))! {
                self.allProducts.append(item)
            }
        }

        if searchText.isEmpty {
            self.allProducts = self.tempProducts
        }

        self.collectionView.reloadData()
        searchController.isActive = true
    }
        
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchController.isActive = false
    }

}

