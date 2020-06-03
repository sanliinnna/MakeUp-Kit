//
//  Alert.swift
//  MakeUp Kit
//
//  Created by Alina Huk on 03.06.2020.
//  Copyright © 2020 Alina Huk. All rights reserved.
//
import UIKit

func alert(section: String, nav: UINavigationController, vc: UIViewController) {
    let alert = UIAlertController(title: "Your \(section) is empty", message: "There is no product. Add some products first.", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Go back", style: .default, handler: { (action) in
        alert.dismiss(animated: true, completion: nil)
        nav.popViewController(animated: true)
    }))
    vc.present(alert, animated: true)
}
