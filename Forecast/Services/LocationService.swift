//
//  LocationService.swift
//  Forecast
//
//  Created by Pouria Almassi on 5/12/20.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func locationService(_ manager: CLLocationManager, didUpdateLocation location: CLLocation)
}

final class LocationService: NSObject {
    weak var delegate: LocationServiceDelegate?

    private lazy var manager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        return manager
    }()

    deinit {
        manager.stopUpdatingLocation()
        manager.delegate = nil
    }

    func requestAuthorization() {
        switch CLLocationManager().authorizationStatus {
        case .denied, .restricted:
            print("Can not access location. Notify user.")

        case .authorizedAlways, .authorizedWhenInUse:
            startUpdatingLocation()
            break

        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            startUpdatingLocation()

        @unknown default:
            break
        }
    }

    private func startUpdatingLocation() {
        manager.startUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        delegate?.locationService(manager, didUpdateLocation: location)
    }
}
