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
    /// Call To Action button color
    var ctaColor = UIColor.orangeCTAColor
    /// Value is in minutes
    var freeOrderTimeLimit = 30

    var minutesLeftForFreeShipping: Int {
        let minutesPassed = Date().timeIntervalSince(startDate) / TimeInterval(60)
        let minutesLeft = freeOrderTimeLimit - Int(minutesPassed)
        return minutesLeft < 0 ? 0 : minutesLeft
    }

    func reportEvent(_ name: String, with properties: [String: Any] = [:]) {
    }
}
