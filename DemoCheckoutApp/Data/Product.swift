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
    let description:        String
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

struct CheckoutItem {
    let product: Product
    var count = 0
}

class Order {
    var checkoutItems = [CheckoutItem]()
    var discount: Int = 0

    var totalCount: Int {
        var totalCount = 0
        for item in checkoutItems {
            totalCount += item.count
        }
        return totalCount
    }

    var subTotalCost: Float {
        var totalCost = Float(0)
        for item in checkoutItems {
            totalCost += item.product.price * Float(item.count)
        }
        return totalCost
    }

    var totalCost: Float {
        return subTotalCost * Float(100 - discount) / 100
    }

    func contains(_ product: Product) -> Bool {
        return index(of: product) != nil
    }

    func add(_ product: Product) {
        if let index = index(of: product) {
            checkoutItems[index].count += 1
        } else {
            checkoutItems.append(CheckoutItem(product: product, count: 1))
        }
    }

    func index(of product: Product) -> Int? {
        return checkoutItems.index(where: { addedProduct -> Bool in
            return addedProduct.product.id == product.id
        })
    }
}
