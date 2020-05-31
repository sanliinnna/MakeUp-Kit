//
//  ProductRequest.swift
//  MakeUp Kit
//
//  Created by Alina Huk on 31.05.2020.
//  Copyright © 2020 Alina Huk. All rights reserved.
//

import Foundation

struct Product: Decodable {
    
    let id: Int?
    let brand: String?
    let name: String?
    let price: String?
    let imageLink: String?
    let productLink: String?
    let description: String?
    let rating: Double?
    let category: String?
    let productType: String?
    let productColors: [Color]
    
    enum CodingKeys: String, CodingKey {
    case id
    case brand
    case name
    case price
    case imageLink = "image_link"
    case productLink = "product_link"
    case description
    case rating
    case category
    case productType = "product_type"
    case productColors = "product_colors"
    }

}

struct Color: Decodable {
    let hexValue: String?
    let colourName: String?
    
    enum CodingKeys: String, CodingKey {
        case hexValue = "hex_value"
        case colourName = "colour_name"
        
    }
}

enum ProductError: Error {
    case dataUnavailable
    case cannotProccessData
}

struct ProductRequest {
    let requestUrl: URL

    init() {
        self.requestUrl = URL(string: "http://makeup-api.herokuapp.com/api/v1/products.json?rating_greater_than=4")!
    }

    func getProducts(completionHandler: @escaping(Result<[Product], ProductError>) -> Void) {
        URLSession.shared.dataTask(with: self.requestUrl) { (data, response, error) in
            guard let data = data else {
                completionHandler(.failure(.dataUnavailable))
                return
            }
            do {
                let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
                completionHandler(.success(productResponse.products))
            } catch {
                completionHandler(.failure(.cannotProccessData))
            }

        }.resume()
    }

}

