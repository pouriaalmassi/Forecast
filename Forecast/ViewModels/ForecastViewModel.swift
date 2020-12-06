//
//  ForecastViewModel.swift
//  Forecast
//
//  Created by Pouria Almassi on 5/12/20.
//

import UIKit
import CoreLocation

protocol ForecastViewModelDelegate: AnyObject {
    func forecastViewModelDidFail(_ error: Error)
    func forecastViewModelDidSucceed()
    func forecastViewModelDidUpdateWithLocationString(_ locationString: String)
}

final class ForecastViewModel: NSObject {
    private var service: WebService<OWMResponse>?
    private var locationService: LocationService?
    private var data: [Response]?
    weak var delegate: ForecastViewModelDelegate?
    private let throttler = Throttler(minimumDelay: 2.0)

    init(service: WebService<OWMResponse>?, locationService: LocationService?) {
        super.init()
        self.service = service
        self.locationService = locationService
        self.locationService?.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCell.reuseIdentifier, for: indexPath) as? ForecastCell,
            let data = data?[indexPath.row]
        else { return UITableViewCell() }
        cell.setup(with: ForecastCellViewModel(data: data))
        return cell
    }

    func searchLastForecast() {
        service?.lastForecast({ [weak self] result in
            self?.handleResult(result, completion: nil)
        })
    }

    private func searchUserQuery(_ searchString: String) {
        // Support only numeric post codes.
        let request: WebServiceRequest = searchString.isNumeric ? .postCode(searchString) : .cityName(searchString)
        loadData(with: request, completion: nil)
    }

    private func searchCoordinate(_ coordinates: CLLocationCoordinate2D) {
        let request = WebServiceRequest.coordinates(lat: coordinates.latitude, lon: coordinates.longitude)
        loadData(with: request, completion: { [weak self] in
            let locationString = "\(coordinates.latitude), \(coordinates.longitude)"
            self?.delegate?.forecastViewModelDidUpdateWithLocationString(locationString)
        })
    }

    private func loadData(with request: WebServiceRequest, completion: VoidCallback?) {
        throttler.throttle { [weak self] in
            self?.service?.forecast(request, completion: { result in
                self?.handleResult(result, completion: completion)
            })
        }
    }

    private func handleResult(_ result: WebService<OWMResponse>.Result, completion: VoidCallback?) {
        switch result {
        case .error(let error):
            switch error {
            case .decoder(error: let error):
                print("Decoding error: \(error.localizedDescription)")
            case .generic(error: let error):
                print("Generic error: \(error?.localizedDescription ?? "")")
            case .badInput:
                print("Error formatting URL.")
            case .nilResponse:
                print("Nil response from API.")
            case .nilData:
                print("Nil data from API.")
            case .clientError(statusCode: let statusCode):
                print("Client error with status code \(statusCode).")
            case .serverError(statusCode: let statusCode):
                print("Server error with status code \(statusCode).")
            }
            completion?()
            self.delegate?.forecastViewModelDidFail(error)

        case .success(let data):
            completion?()
            self.data = [data]
            self.delegate?.forecastViewModelDidSucceed()
        }
    }

    // MARK: - LocationService

    func requestLocationAuthorization() {
        locationService?.requestAuthorization()
    }
}

extension ForecastViewModel: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else { return }

        if !searchBarText.isBlank {
            searchUserQuery(searchBarText)
        }

        if let searchResultsController = searchController.searchResultsController as? SearchResultsController {
            searchResultsController.tableView.reloadData()
        }
    }
}

extension ForecastViewModel: LocationServiceDelegate {
    func locationService(_ manager: CLLocationManager, didUpdateLocation location: CLLocation) {
        searchCoordinate(location.coordinate)
    }
}
