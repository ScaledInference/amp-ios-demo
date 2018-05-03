//
//  Order.swift
//  DemoCheckoutApp
//
//  Created by Olha Prokopiuk on 5/2/18.
//  Copyright © 2018 Scaled Inference. All rights reserved.
//

import Foundation

class Order {
    var checkoutItems = [CheckoutItem]()
    var discount: Int = 5

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

    var discountAmount: Float {
        return subTotalCost * Float(discount) / 100
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

    func addedCount(_ product: Product) -> Int? {
        if let index = index(of: product) {
            return checkoutItems[index].count
        }
        return nil
    }
}

struct CheckoutItem {
    let product: Product
    var count = 0
}
