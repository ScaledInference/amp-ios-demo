//
//  ViewController.swift
//  DemoCheckoutApp
//
//  Created by Olha Prokopiuk on 4/27/18.
//  Copyright © 2018 Olha Prokopiuk. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var counterButton: UIButton!

    let dataProvider: DataProvider = DataProvider.shared
    let session: Session = Session()

    override func viewDidLoad() {
        super.viewDidLoad()

        UIView.appearance().tintColor = session.ctaColor
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
        updateOrderInformation()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? PreviewViewController {
            viewController.session = session
        }
    }
}

extension StoreViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataProvider.categories.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.categories[section].products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCellId") as! ProductCell
        let product = dataProvider.categories[indexPath.section].products[indexPath.row]
        cell.product = product
        cell.addedCount = session.order.addedCount(product)
        cell.addButton.backgroundColor = session.ctaColor
        cell.delegate = self

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataProvider.categories[section].title
    }

    func updateOrderInformation() {
        counterButton.titleLabel?.text = "\(session.order.totalCount)"
    }
}

extension StoreViewController: CartProtocol {
    func addToCart(_ сell: ProductCell) {
        if let indexPath = tableView.indexPath(for: сell) {
            let product = dataProvider.categories[indexPath.section].products[indexPath.row]
            session.order.add(product)

            session.reportEvent("Product added", with: ["id": product.id])

            updateOrderInformation()
            UIView.animate(withDuration: 0.5) {
                сell.addedCount = self.session.order.addedCount(product)
            }
        }
    }
}
