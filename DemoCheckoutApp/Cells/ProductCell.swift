//
//  ProductCell.swift
//  DemoCheckoutApp
//
//  Created by Olha Prokopiuk on 4/27/18.
//  Copyright © 2018 Olha Prokopiuk. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!

    var delegate: CartProtocol?

    var addedCount: Int? {
        didSet {
            if let amount = addedCount {
                addButton.setTitle("Added \(amount)", for: .normal)
            } else {
                addButton.setTitle("Add", for: .normal)
            }
        }
    }

    var product: Product! {
        didSet {
            titleLabel.text = product.name
            detailsLabel.text = product.description
            priceLabel.text = "\(product.price)"
            pictureImageView.image = UIImage(named: product.id + ".jpg")
        }
    }

    @IBAction func add(_ sender: UIButton) {
        delegate?.addToCart(self)
    }
}

protocol CartProtocol {
    func addToCart(_ сell: ProductCell)
}
