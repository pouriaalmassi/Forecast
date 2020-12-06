//
//  WebServiceError.swift
//  Forecast
//
//  Created by Pouria Almassi on 6/12/20.
//

import Foundation

enum WebServiceError: Error {
    case decoder(error: Error)
    case generic(error: Error?)
    case badInput
    case nilResponse
    case nilData
    case clientError(statusCode: Int)
    case serverError(statusCode: Int)
}
