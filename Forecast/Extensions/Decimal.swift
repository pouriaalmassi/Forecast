//
//  Decimal.swift
//  Forecast
//
//  Created by Pouria Almassi on 5/12/20.
//

import Foundation

extension Decimal {
    var temperatureString: String {
        "\(String(format: "%.0f", NSDecimalNumber(decimal: self).doubleValue))°"
    }
}
