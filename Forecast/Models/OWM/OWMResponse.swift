//
//  OWMResponse.swift
//  Forecast
//
//  Created by Pouria Almassi on 5/12/20.
//

import Foundation

// Using the 'OWM' prefix to indicate these models belong specifically to openweathermap.org.
struct OWMResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case _name = "name"
        case _main = "main"
        case _weather = "weather"
    }

    let _name: String?
    let _main: OWMMain?
    let _weather: [OWMWeather]?
}

extension OWMResponse: Response {
    var name: String? {
        _name
    }

    var main: Main? {
        _main
    }

    var weather: [Weather]? {
        _weather
    }
}
