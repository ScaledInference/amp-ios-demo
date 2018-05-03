//
//  CheckoutCell.swift
//  DemoCheckoutApp
//
//  Created by Olha Prokopiuk on 4/30/18.
//  Copyright © 2018 Olha Prokopiuk. All rights reserved.
//

import UIKit

class CheckoutCell: UITableViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper?

    weak var delegate: CounterProtocol?

    var checkoutItem: CheckoutItem! {
        didSet {
            pictureImageView.image = UIImage(named: checkoutItem.product.id + ".jpg")
            titleLabel.text = checkoutItem.product.name
            priceLabel.text = String(format: "%.02f", checkoutItem.product.price)
            countLabel.text = "\(checkoutItem.count)"
            stepper?.value = Double(checkoutItem.count)
        }
    }

    @IBAction func updateCount(_ sender: UIStepper) {
        let newCount = Int(sender.value)
        countLabel.text = "\(newCount)"
        delegate?.update(with: newCount, cell: self)
    }
}

protocol CounterProtocol: class {
    func update(with count: Int, cell: CheckoutCell)
}
