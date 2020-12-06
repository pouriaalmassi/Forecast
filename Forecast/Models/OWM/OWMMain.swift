//
//  OWMMain.swift
//  Forecast
//
//  Created by Pouria Almassi on 5/12/20.
//

import Foundation

// Using the 'OWM' prefix to indicate these models belong specifically to openweathermap.org.
struct OWMMain: Codable {
    enum CodingKeys: String, CodingKey {
        // Modify OWM's naming convention.
        case _currentTemperature = "temp"
        case _minTemperature = "temp_min"
        case _maxTemperature = "temp_max"
    }

    var _currentTemperature: Decimal?
    var _minTemperature: Decimal?
    var _maxTemperature: Decimal?
}

extension OWMMain: Main {
    var currentTemperature: Decimal? {
        _currentTemperature
    }
    
    var minTemperature: Decimal? {
        _minTemperature
    }

    var maxTemperature: Decimal? {
        _maxTemperature
    }
}
