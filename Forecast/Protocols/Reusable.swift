//
//  Reusable.swift
//  Forecast
//
//  Created by Pouria Almassi on 5/12/20.
//

import UIKit

protocol Reusable: UIView {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
