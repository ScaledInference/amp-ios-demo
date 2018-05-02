//
//  PreviewViewController.swift
//  DemoCheckoutApp
//
//  Created by Olha Prokopiuk on 4/30/18.
//  Copyright © 2018 Olha Prokopiuk. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

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
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? CheckoutViewController {
            viewController.order = order
        }
    }
}

extension PreviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.checkoutItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutCellId") as! CheckoutCell
        cell.checkoutItem = order.checkoutItems[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension PreviewViewController: CounterProtocol {
    func update(with count: Int, cell: CheckoutCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let index = indexPath.row
            if count == 0 {
                order.checkoutItems.remove(at: index)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                order.checkoutItems[index].count = count
            }
        }
        updateOrderInformation()
    }
}
