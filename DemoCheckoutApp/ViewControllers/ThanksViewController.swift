//
//  ThanksViewController.swift
//  DemoCheckoutApp
//
//  Created by Olha Prokopiuk on 5/1/18.
//  Copyright © 2018 Olha Prokopiuk. All rights reserved.
//

import UIKit

class ThanksViewController: UIViewController {
    @IBOutlet weak var newOrderButton: UIButton!

    override func viewDidLoad() {
        newOrderButton.backgroundColor = UIView.appearance().tintColor
    }

    @IBAction func makeNewOrder() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let initialViewController = storyboard.instantiateInitialViewController()

        UIView.transition(with: self.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.view.window!.rootViewController = initialViewController
        })
    }
}
