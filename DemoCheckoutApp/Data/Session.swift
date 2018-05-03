//
//  File.swift
//  DemoCheckoutApp
//
//  Created by Olha Prokopiuk on 5/2/18.
//  Copyright © 2018 Scaled Inference. All rights reserved.
//

import Foundation
import UIKit

class Session {
    let order = Order()
    let startDate = Date()
    /// "Call to action" button color
    var ctaColor = UIColor.greenCtaColor
    /// Time given to place an order to get free shipping in minutes
    var freeShippingTimeLimit = 30

    var minutesLeftForFreeShipping: Int {
        let minutesPassed = Date().timeIntervalSince(startDate) / TimeInterval(60)
        let minutesLeft = freeShippingTimeLimit - Int(minutesPassed)
        return minutesLeft < 0 ? 0 : minutesLeft
    }

    func reportEvent(_ name: String, with properties: [String: Any] = [:]) {
    }
}
