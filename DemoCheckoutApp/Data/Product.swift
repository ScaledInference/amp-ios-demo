//
//  Product.swift
//  DemoCheckoutApp
//
//  Created by Olha Prokopiuk on 4/27/18.
//  Copyright © 2018 Olha Prokopiuk. All rights reserved.
//

import Foundation

struct Category: Codable {
    let title: String
    let products: [Product]
}

struct Product: Codable {
    let id:                 String
    let name:               String
    let details:            String
    let price:              Float
}

extension Product: Hashable {
    public var hashValue: Int {
        return id.hashValue
    }

    public static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
