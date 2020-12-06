//
//  StorageService.swift
//  Forecast
//
//  Created by Pouria Almassi on 6/12/20.
//

import Foundation

struct StorageService {
    private let userDefaults = UserDefaults.standard

    private enum Key {
        static let lastForecastUrlString = "LastForecastUrlString"
    }

    func setLastUrlString(_ urlString: String) {
        if let encoded = try? JSONEncoder().encode(urlString) {
            userDefaults.set(encoded, forKey: Key.lastForecastUrlString)
        }
    }

    func lastUrlString() -> String? {
        if let data = userDefaults.object(forKey: Key.lastForecastUrlString) as? Data {
            if let decoded = try? JSONDecoder().decode(String.self, from: data) {
                return decoded
            }
        }
        return nil
    }
}
