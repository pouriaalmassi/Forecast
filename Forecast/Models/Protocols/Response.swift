//
//  Response.swift
//  Forecast
//
//  Created by Pouria Almassi on 5/12/20.
//

import Foundation

// Provide a more generic representation of a weather API response should we want to change providers in the future.
// Currently this mirrors OWM's response.
protocol Response where Self: Codable {
    /// Name as provided by API response.
    var name: String? { get }

    /// Forecast weather values, temperature, humidity, etc.
    var main: Main? { get }

    /// Array of weather for a given location including high level description, icon, etc.
    var weather: [Weather]? { get }

    // See protocol extension.

    /// A boolean indicating whether or not the response is valid.
    var isValid: Bool { get }

    /// Name of a given location e.g. "Los Angeles", "Sydney", etc.
    var locationString: String? { get }

    /// Displayable forecast for a given location e.g. "Snow", "Sunny", etc.
    var forecastString: String? { get }

    /// Current temperature for a given location.
    var currentTemperature: Decimal? { get }

    /// Min temperature for a given location.
    var minTemperature: Decimal? { get }

    /// Max temperature for a given location.
    var maxTemperature: Decimal? { get }
}

extension Response {
    // Provide default implementation for the following.
    var isValid: Bool {
        name != nil && main != nil && weather != nil && weather?.isEmpty == false && currentTemperature != nil && minTemperature != nil && maxTemperature != nil
    }

    var locationString: String? {
        name
    }

    var forecastString: String? {
        weather?.first?.main
    }

    var currentTemperature: Decimal? {
        main?.currentTemperature
    }

    var minTemperature: Decimal? {
        main?.minTemperature
    }

    var maxTemperature: Decimal? {
        main?.maxTemperature
    }
}
