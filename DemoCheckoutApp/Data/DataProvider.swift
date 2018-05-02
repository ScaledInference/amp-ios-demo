//
//  DataProvider.swift
//  DemoCheckoutApp
//
//  Created by Olha Prokopiuk on 4/27/18.
//  Copyright © 2018 Olha Prokopiuk. All rights reserved.
//

import Foundation
class DataProvider {
    static private let decoder = JSONDecoder()
    static let shared = DataProvider()

    lazy var categories: [Category] = {
        let fileName = "sample_data"

        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                fatalError("File: \(fileName) can't be read.")
        }

        return try! DataProvider.decoder.decode([Category].self, from: data)
    }()
}
