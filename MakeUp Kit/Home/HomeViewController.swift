//
//  HomeViewController.swift
//  MakeUp Kit
//
//  Created by Alina Huk on 29.05.2020.
//  Copyright © 2020 Alina Huk. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
//    MARK: - Variables, Constants & Outlets
    
    var sections: [Section]?
    let vcs = ["Kit", "Wishlist"]

    @IBOutlet weak var collectionView: UICollectionView!
    
//    MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetch()
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    //    MARK: - Functions
    
    func fetch() {
        sections = Section.fetchSections()
    }
}

//    MARK: -
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    // MARK: - Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionCollectionViewCell", for: indexPath) as! SectionCollectionViewCell
        let section = sections![indexPath.item]
        cell.section = section
        return cell
    }
    
    // MARK: - Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = vcs[indexPath.item]
        let VC = UIStoryboard(name: vc, bundle: nil).instantiateViewController(identifier: "\(vc)VC")
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    // MARK: - Scroll View Delegate
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        
        targetContentOffset.pointee = offset
        
    }
    
}
