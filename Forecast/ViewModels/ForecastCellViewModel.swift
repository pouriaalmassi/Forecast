//
//  ForecastCellViewModel.swift
//  Forecast
//
//  Created by Pouria Almassi on 5/12/20.
//

import Foundation

struct ForecastCellViewModel {
    let data: Response

    var locationString: String {
        data.locationString ?? ""
    }

    var forecastString: String {
        data.forecastString ?? ""
    }

    var currentTemperatureString: String {
        guard let currentTemperature = data.currentTemperature else { return "" }
        return currentTemperature.temperatureString
    }

    var minMaxTemperatureString: String {
        guard let minTemperature = data.minTemperature else { return "" }
        guard let maxTemperature = data.maxTemperature else { return "" }
        return "L \(minTemperature.temperatureString) / H \(maxTemperature.temperatureString)"
    }
}
