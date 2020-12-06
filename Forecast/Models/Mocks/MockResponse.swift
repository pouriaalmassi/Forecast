//
//  MockResponse.swift
//  Forecast
//
//  Created by Pouria Almassi on 6/12/20.
//

import Foundation

struct MockResponse: Codable {
    private var _name: String?
    private var _main: MockMain?
    private var _weather: [MockWeather]?

    init(name: String?, main: MockMain?, weather: [MockWeather]?) {
        _name = name
        _main = main
        _weather = weather
    }
}

extension MockResponse: Response {
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
