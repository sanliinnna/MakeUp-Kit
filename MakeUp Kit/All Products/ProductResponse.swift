//
//  ProductResponse.swift
//  MakeUp Kit
//
//  Created by Alina Huk on 31.05.2020.
//  Copyright © 2020 Alina Huk. All rights reserved.
//

import Foundation

struct ProductResponse: Decodable {
    
    var products: [Product]
    
    init(from decoder: Decoder) throws {
        var products = [Product]()
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            if let route = try? container.decode(Product.self) {
                products.append(route)
            } else {
                _ = try? container.decode(DummyData.self)
            }
        }
        self.products = products
    }
    
}

private struct DummyData: Decodable { }
