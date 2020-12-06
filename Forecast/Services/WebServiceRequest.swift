//
//  WebServiceRequest.swift
//  Forecast
//
//  Created by Pouria Almassi on 6/12/20.
//

import Foundation

enum WebServiceRequest {
    case cityName(_ name: String)
    case postCode(_ code: String) // Assumes AU.
    case coordinates(lat: Double, lon: Double)

    var urlString: String {
        let baseUrlString = "https://api.openweathermap.org/data/2.5/weather"
        switch self {
        case .cityName(let name):
            guard let escapedString = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return "" }
            let result = "\(baseUrlString)?units=metric&q=\(escapedString)"
            return result

        case .postCode(let codeString):
            guard let codeInt = Int(codeString) else { return "" }
            return "\(baseUrlString)?units=metric&zip=\(codeInt),AU"

        case .coordinates(let lat, let lon):
            return "\(baseUrlString)?units=metric&lat=\(lat)&lon=\(lon)"
        }
    }
}
