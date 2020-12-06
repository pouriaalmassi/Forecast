//
//  Weather.swift
//  Forecast
//
//  Created by Pouria Almassi on 6/12/20.
//

import Foundation

protocol Weather where Self: Codable {
    var main: String? { get }
}
