//
//  productModal.swift
//  MachinTest
//
//  Created by STC on 01/09/23.
//

import Foundation
struct ProductApiResponce : Decodable{
    let products: [Product]
}
struct Product : Decodable{
    let title, description: String
        let price: Int
        let rating: Double
}
