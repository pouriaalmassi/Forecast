//
//  OWMWeather.swift
//  Forecast
//
//  Created by Pouria Almassi on 5/12/20.
//

import Foundation

// Using the 'OWM' prefix to indicate these models belong specifically to openweathermap.org.
struct OWMWeather: Codable {
    enum CodingKeys: String, CodingKey {
        case _main = "main"
    }

    let _main: String?
}

extension OWMWeather: Weather {
    var main: String? {
        _main
    }
}
