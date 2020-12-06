//
//  UIColor.swift
//  Forecast
//
//  Created by Pouria Almassi on 5/12/20.
//

import UIKit

extension UIColor {
    class var primaryForegroundColor: UIColor {
        .label
    }

    class var primaryBackgroundColor: UIColor {
        .systemBackground
    }

    class var forecastCellBackgroundColor: UIColor {
        UIColor(named: "forecastCellBackgroundColor") ?? .systemBackground
    }
}
