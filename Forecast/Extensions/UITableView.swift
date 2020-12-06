//
//  UITableView.swift
//  Forecast
//
//  Created by Pouria Almassi on 5/12/20.
//

import UIKit

extension UITableView {
    func registerClassForCell<T: Reusable>(_ cell: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
}
