//
//  WebService.swift
//  Forecast
//
//  Created by Pouria Almassi on 5/12/20.
//

import Foundation

struct WebService<T: Response> {
    let store: StorageService
    let configuration: Configuration

    typealias ResultCallback = (Result) -> ()

    enum Result {
        case success(objs: T)
        case error(errorType: WebServiceError)
    }

    func lastForecast(_ completion: ResultCallback?) {
        guard let lastUrlString = store.lastUrlString(), let url = URL(string: lastUrlString) else { return }
        urlForecast(url, completion: completion)
    }

    func forecast(_ request: WebServiceRequest, completion: ResultCallback?) {
        guard let url = URL(string: "\(request.urlString)&appid=\(configuration.apiKey)") else {
            completion?(.error(errorType: .badInput))
            return
        }
        urlForecast(url, completion: completion)
    }

    private func urlForecast(_ url: URL, completion: ResultCallback?) {
        let request = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, dataTaskError) in
            guard dataTaskError == nil else {
                completion?(.error(errorType: .generic(error: dataTaskError)))
                return
            }

            guard response != nil, let response = response as? HTTPURLResponse else {
                completion?(.error(errorType: .nilResponse))
                return
            }

            // Check HTTP status code for errors.
            switch response.statusCode {
            case 400...499:
                completion?(.error(errorType: .clientError(statusCode: response.statusCode)))
                return

            case 500...599:
                completion?(.error(errorType: .serverError(statusCode: response.statusCode)))
                return

            default:
                ()
            }

            guard let data = data else {
                completion?(.error(errorType: .nilData))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                if decoded.isValid {
                    store.setLastUrlString(url.absoluteString)
                    completion?(.success(objs: decoded))
                } else {
                    completion?(.error(errorType: .nilData))
                }
            } catch let caughtError {
                completion?(.error(errorType: .decoder(error: caughtError)))
            }
        }
        dataTask.resume()
    }
}
