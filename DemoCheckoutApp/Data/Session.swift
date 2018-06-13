//
//  File.swift
//  DemoCheckoutApp
//
//  Created by Olha Prokopiuk on 5/2/18.
//  Copyright © 2018 Scaled Inference. All rights reserved.
//

import Foundation
import UIKit
import AmpiOS

class Session {
    static let key = "94f9dd5f9bb946a1"
    static let amp = Amp(key: Session.key)
    static let colorKey = "color"
    static let freeShippingTimeKey = "free_shipping_time"

    let order = Order()
    let startDate = Date()

    /// "Call to action" button color
    let ctaColor: UIColor
    /// Time given to place an order to get free shipping in minutes
    let freeShippingTimeLimit: Int

    init() {
        _  = Session.amp.session(userId: "some_user_id")

        // Context before decide
        let customer = Customer()
        Session.amp.observe(name: "CustomerContext", properties: customer.info())

        let candidates = [
            Session.colorKey: [CtaColor.green.rawValue, CtaColor.orange.rawValue, CtaColor.red.rawValue],
            Session.freeShippingTimeKey: [0, 30, 60, 120]]
        let decision = Session.amp.decide(name: "AmpedCart", candidates: candidates)
        ctaColor = CtaColor(rawValue: decision[Session.colorKey] as! String)!.color
        freeShippingTimeLimit = decision[Session.freeShippingTimeKey] as! Int
    }

    var minutesLeftForFreeShipping: Int {
        let minutesPassed = Date().timeIntervalSince(startDate) / TimeInterval(60)
        let minutesLeft = freeShippingTimeLimit - Int(minutesPassed)
        return minutesLeft < 0 ? 0 : minutesLeft
    }

    func reportEvent(_ name: String, with properties: [String: Any] = [:]) {
        Session.amp.observe(name: name, properties: properties)
    }

    enum CtaColor: String {
        case green
        case orange
        case red

        var color: UIColor {
            switch self {
            case .green:
                return UIColor.greenCtaColor
            case .orange:
                return UIColor.orangeCtaColor
            case .red:
                return UIColor.redCtaColor
            }
        }
    }
}
