////
////  DBManager.swift
////  MakeUp Kit
////
////  Created by Alina Huk on 31.05.2020.
////  Copyright © 2020 Alina Huk. All rights reserved.
////
//
//import Foundation
//import CoreData
//
//class DManager {
//    
//    static var share = DManager()
//    
//    var products: [MyProd]? {
//        get {
//            return getData()
//        }
//    }
//    
//    let manageContext = appDelegate?.persistentContainer.viewContext
//    
//    
//    func saveProduct(name: String?) {
//        
//        guard let manageContext = manageContext else { return }
//        let product = MyProd(context: manageContext)
//        product.name = name
//        saveContext()
//    }
//    
//    func delete(product: MyProd) {
//        manageContext?.delete(product)
//        saveContext()
//    }
//    
//    private func getData() -> [MyProd]? {
//        
//        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "MyProd")
//        
//        do {
//            return try manageContext?.fetch(req) as? [MyProd]
//        } catch {
//            print("Error getData")
//            return nil
//        }
//        
//    }
//    
//    private func saveContext() {
//        do {
//            try manageContext?.save()
//        } catch {
//            print("Error save manageContext")
//        }
//    }
//}
//
