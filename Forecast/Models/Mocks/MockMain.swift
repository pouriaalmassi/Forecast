//
//  MockMain.swift
//  Forecast
//
//  Created by Pouria Almassi on 6/12/20.
//

import Foundation

struct MockMain {
    private var _temp: Decimal?
    private var _tempMin: Decimal?
    private var _tempMax: Decimal?

    init(temp: Decimal?, tempMin: Decimal?, tempMax: Decimal?) {
        _temp = temp
        _tempMin = tempMin
        _tempMax = tempMax
    }
}

extension MockMain: Main {
    var currentTemperature: Decimal? {
        _temp
    }

    var minTemperature: Decimal? {
        _tempMin
    }

    var maxTemperature: Decimal? {
        _tempMax
    }
}
