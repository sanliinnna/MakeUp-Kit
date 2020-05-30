////
////  AllProductsViewController.swift
////  MakeUp Kit
////
////  Created by Alina Huk on 31.05.2020.
////  Copyright © 2020 Alina Huk. All rights reserved.
////
//
//import UIKit
//
//class AllProductsViewController: UIViewController {
//    
//    @IBOutlet weak var collectionView: UICollectionView!
//    
//    var allProducts = [Product]() {
//        didSet {
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        }
//    }
//    var neededProducts = [Product]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setupNavBar()
//        
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        
//        ProductRequest().getProducts { result  in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let products):
//                print("No error found.")
//                self.allProducts = products
//                print(self.allProducts.count)
//                self.neededProducts = products
//            }
//        }
//
//    }
//    
//    func setupNavBar() {
//        let searchController = UISearchController(searchResultsController: nil)
//        navigationItem.searchController = searchController
//        navigationItem.hidesSearchBarWhenScrolling = false
//    }
//
//}
//
//extension AllProductsViewController: UICollectionViewViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//                return allProducts.count
//            }
//            
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
//        let product = allProducts[indexPath.item]
//        cell.productLabel.text = product.name
//        cell.productImageView.contentMode = .scaleAspectFill
//        cell.productImageView.downloaded(from: product.imageLink!)
//        return cell
//        
//    }
//            
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "productDetails") as! ProductDetailsViewController
//        let product = allProducts[indexPath.item]
//        vc.product = product
//        self.present(vc, animated: true, completion: nil)
//
//    }
//        
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        
//        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "searchBar", for: indexPath)
//        return searchView
//        
//    }
//        
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
//        self.allProducts.removeAll()
//        print(self.allProducts.count)
//        print(self.neededProducts.count)
//    
//        for item in self.neededProducts {
//            if (item.name?.lowercased().contains(searchBar.text!.lowercased()))! {
//                self.allProducts.append(item)
//                print(self.allProducts.count)
//            }
//        }
//        
//        if searchBar.text!.isEmpty {
//            self.allProducts = self.neededProducts
//            print(self.allProducts.count)
//        }
//        
//        self.collectionView.reloadData()
//    }
//        
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
////        if !searchBar.text!.isEmpty && self.allProducts.count != self.neededProducts.count {
////            searchBar.text = ""
//            self.allProducts = self.neededProducts
//            self.collectionView.reloadData()
////        }
//    }
//
//}
//
