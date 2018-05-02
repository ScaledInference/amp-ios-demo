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
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var freeShippingLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    
    var session: Session!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        checkoutButton.backgroundColor = UIView.appearance().tintColor
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        freeShippingLabel.text = "Order in \(session.minutesLeftForFreeShipping) minues to get a free shipping."
        updateOrderInformation()
    }

    func updateOrderInformation() {
        subtotalLabel.text = "\(session.order.subTotalCost)"
        countLabel.text = "\(session.order.totalCount)"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? CheckoutViewController {
            viewController.session = session
        }
    }
}

extension PreviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return session.order.checkoutItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutCellId") as! CheckoutCell
        cell.checkoutItem = session.order.checkoutItems[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension PreviewViewController: CounterProtocol {
    func update(with count: Int, cell: CheckoutCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let index = indexPath.row
            if count == 0 {
                session.order.checkoutItems.remove(at: index)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                session.order.checkoutItems[index].count = count
            }
        }
        updateOrderInformation()
    }
}
