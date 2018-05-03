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
    @IBOutlet weak var placeOrderButton: UIButton!

    var session: Session!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        placeOrderButton.backgroundColor = UIView.appearance().tintColor
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateOrderInformation()
    }

    func updateOrderInformation() {
        subtotalLabel.text = "\(session.order.subtotalCost)"
        discountLabel.text = "\(session.order.discountAmount)"
        totalLabel.text = "\(session.order.totalCost)"
        deliveryDateLabel.text = CheckoutViewController.dateFormatter.string(from: Date())
    }

    @IBAction func placeOrder(_ sender: Any) {
        session.reportEvent("Checkout event", with: ["totalCost": session.order.totalCost,
                                                     "count": session.order.totalCount])
    }
}

extension CheckoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return session.order.checkoutItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutCellId") as! CheckoutCell
        cell.checkoutItem = session.order.checkoutItems[indexPath.row]
        return cell
    }
}
