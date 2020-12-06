//
//  AppCoordinator.swift
//  Forecast
//
//  Created by Pouria Almassi on 5/12/20.
//

import Foundation
import UIKit

final class AppCoordinator {
    var presenter: UINavigationController?
    var service: WebService<OWMResponse>?
    var locationService: LocationService?
}

extension AppCoordinator: Coordinator {
    func start() {
        let viewModel = ForecastViewModel(service: service, locationService: locationService)
        let controller = ForecastViewController(viewModel: viewModel)
        presenter?.pushViewController(controller, animated: true)
    }
}
