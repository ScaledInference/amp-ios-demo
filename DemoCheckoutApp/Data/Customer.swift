//
//  Customer.swift
//  DemoCheckoutApp
//
//  Created by Olha Prokopiuk on 6/13/18.
//  Copyright © 2018 Scaled Inference. All rights reserved.
//

import Foundation

struct Customer {
    let hasSlowConnection = Bool.random()
    let isNew = Bool.random()
    let country = Customer.randomCountry()

    func info() -> [String: String] {
        var info = [String: String]()
        info["country"] = country
        info["type"] = isNew ? "new_customer" : "returning_customer"
        info["connection"] = hasSlowConnection ? "slow" : "fast"
        return info
    }
}

extension Customer {
    static let countries = ["🇺🇸", "🇬🇧", "🇷🇺", "🇺🇦", "🇮🇱", "🇮🇳", "🇨🇳", "🇹🇷"]

    static func randomCountry() -> String {
        let index = Int(arc4random_uniform(UInt32(countries.count)))
        return  countries[index];
    }
}

extension Bool {
    static func random() -> Bool {
        return arc4random_uniform(2) == 0
    }
}
