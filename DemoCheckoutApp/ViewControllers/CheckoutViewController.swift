//
//  CheckoutViewController.swift
//  DemoCheckoutApp
//
//  Created by Olha Prokopiuk on 5/1/18.
//  Copyright © 2018 Olha Prokopiuk. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var deliveryDateLabel: UILabel!

    var order: Order!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateOrderInformation()
    }

    func updateOrderInformation() {
        subtotalLabel.text = "\(order.subTotalCost)"
        discountLabel.text = "\(order.discount)"
        totalLabel.text = "\(order.totalCost)"
        deliveryDateLabel.text = CheckoutViewController.dateFormatter.string(from: Date())
    }
}

extension CheckoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.checkoutItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutCellId") as! CheckoutCell
        cell.checkoutItem = order.checkoutItems[indexPath.row]
        return cell
    }
}
