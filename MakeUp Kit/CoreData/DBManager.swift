//
//  DBManager.swift
//  MakeUp Kit
//
//  Created by Alina Huk on 31.05.2020.
//  Copyright © 2020 Alina Huk. All rights reserved.
//

import Foundation
import CoreData

class DBManager {
    
    static var share = DBManager()
    
    var products: [MyKitProduct]? {
        get {
            return getData()
        }
    }
    
    let manageContext = appDelegate?.persistentContainer.viewContext
    
    
    func saveProduct(id: Int, name: String?, brand: String?, type: String?, price: String?, imageLink: String?, productLink: String?, description: String?, section: String?) {
        
        guard let manageContext = manageContext else { return }
        let product = MyKitProduct(context: manageContext)
        product.id = Int16(id)
        product.name = name
        product.brand = brand
        product.productType = type
        product.price = price
        product.imageLink = imageLink
        product.productLink = productLink
        product.section = section
        
        saveContext()
    
    }
    
    func delete(product: MyKitProduct) {
        manageContext?.delete(product)
        saveContext()
    }
    
    func updateSection(product: MyKitProduct, section: String) {
        product.section = section
        saveContext()
    }
    
    
    
    
    
    private func getData() -> [MyKitProduct]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MyKitProduct")
        
        do {
            return try manageContext?.fetch(request) as? [MyKitProduct]
        } catch {
            print("Error getData")
            return nil
        }
        
//        do {
//            let products = try manageContext?.fetch(request)
//            if products!.count > 0 {
//                for product in products as! [NSManagedObject] {
//                    if let id = product.value(forKey: "id") as? Int16 {
//
//                    }
//                }
//            }
//        } catch {
//            print("Error getData")
//            return nil
//        }
        
    }
    private func saveContext() {
        do {
            try manageContext?.save()
        } catch {
            print("Error save manageContext")
        }
    }
}

