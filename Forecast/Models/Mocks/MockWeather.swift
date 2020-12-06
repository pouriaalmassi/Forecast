//
//  MockWeather.swift
//  Forecast
//
//  Created by Pouria Almassi on 6/12/20.
//

import Foundation

struct MockWeather: Codable {
    private var _main: String?

    init(main: String?) {
        _main = main
    }
}

extension MockWeather: Weather {
    var main: String? {
        _main
    }
}

