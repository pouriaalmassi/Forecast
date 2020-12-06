//
//  Main.swift
//  Forecast
//
//  Created by Pouria Almassi on 6/12/20.
//

import Foundation

protocol Main where Self: Codable {
    var currentTemperature: Decimal? { get }
    var minTemperature: Decimal? { get }
    var maxTemperature: Decimal? { get }
}
