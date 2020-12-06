//
//  WebServiceTests.swift
//  WebServiceTests
//
//  Created by Pouria Almassi on 4/12/20.
//

import XCTest
@testable import Forecast

class WebServiceTests: XCTestCase {
    private let apiKey = "95d190a434083879a6398aafd54d9e73"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Test Error Responses

    func testUnauthorizedRequest() throws {
        let anExpectation = expectation(description: "Status code should be 401 provided there is no API key.")

        let configuration = Configuration(apiKey: "")
        let service = WebService<OWMResponse>(
            store: StorageService(),
            configuration: configuration
        )
        let request = WebServiceRequest.cityName("London")

        service.forecast(request, completion: { result in
            switch result {
            case .error(let error):
                switch error {
                case .clientError(let statusCode):
                    XCTAssertEqual(statusCode, 401)

                default:
                    ()
                }
            default:
                ()
            }

            anExpectation.fulfill()
        })

        wait(for: [anExpectation], timeout: 2.0)
    }

    // MARK: - Test City Name Requests

    func testFailedCityNameRequest() throws {
        let anExpectation = expectation(description: "Status code should be 400 (bad request) provided there is no search term.")

        let configuration = Configuration(apiKey: apiKey)
        let service = WebService<OWMResponse>(
            store: StorageService(),
            configuration: configuration
        )
        let request = WebServiceRequest.cityName("")

        service.forecast(request, completion: { result in
            switch result {
            case .error(let error):
                switch error {
                case .clientError(let statusCode):
                    XCTAssertEqual(statusCode, 400)

                default:
                    ()
                }
            default:
                ()
            }

            anExpectation.fulfill()
        })

        wait(for: [anExpectation], timeout: 2.0)
    }

    func testSuccessfulCityNameRequest() throws {
        let anExpectation = expectation(description: "Request should finish.")

        let configuration = Configuration(apiKey: apiKey)
        let service = WebService<OWMResponse>(
            store: StorageService(),
            configuration: configuration
        )
        let request = WebServiceRequest.cityName("Paris")

        service.forecast(request, completion: { result in
            switch result {
            case .error(let errorType):
                XCTAssertNil(errorType)

            case .success(let response):
                XCTAssertTrue(response.isValid)
            }

            anExpectation.fulfill()
        })

        wait(for: [anExpectation], timeout: 5.0)
    }


    // MARK: - Test Post Code Requests

    func testFailedPostCodeRequest() throws {
        let anExpectation = expectation(description: "Status code should be 400 (bad request) provided there is no search term.")

        let configuration = Configuration(apiKey: apiKey)
        let service = WebService<OWMResponse>(
            store: StorageService(),
            configuration: configuration
        )
        let request = WebServiceRequest.postCode("")

        service.forecast(request, completion: { result in
            switch result {
            case .error(let error):
                switch error {
                case .clientError(let statusCode):
                    XCTAssertEqual(statusCode, 400)

                default:
                    ()
                }
            default:
                ()
            }

            anExpectation.fulfill()
        })

        wait(for: [anExpectation], timeout: 2.0)
    }

    func testSuccessfulPostCodeRequest() throws {
        let anExpectation = expectation(description: "Request should finish.")

        let configuration = Configuration(apiKey: apiKey)
        let service = WebService<OWMResponse>(
            store: StorageService(),
            configuration: configuration
        )
        let request = WebServiceRequest.postCode("2000")

        service.forecast(request, completion: { result in
            switch result {
            case .error(let errorType):
                XCTAssertNil(errorType)

            case .success(let response):
                XCTAssertTrue(response.isValid)
            }

            anExpectation.fulfill()
        })

        wait(for: [anExpectation], timeout: 5.0)
    }

    // MARK: - Test Coordinates Requests

    func testFailedCoordinatesRequest() throws {
        let anExpectation = expectation(description: "Request should finish.")

        let configuration = Configuration(apiKey: apiKey)
        let service = WebService<OWMResponse>(
            store: StorageService(),
            configuration: configuration
        )
        // Test with invalid coordinates
        let request = WebServiceRequest.coordinates(lat: 270, lon: -360)

        service.forecast(request, completion: { result in
            switch result {
            case .error(let errorType):
                XCTAssertNotNil(errorType)

            case .success(let response):
                XCTAssertFalse(response.isValid)
            }

            anExpectation.fulfill()
        })

        wait(for: [anExpectation], timeout: 5.0)
    }

    func testSuccessfulCoordinatesRequest() throws {
        let anExpectation = expectation(description: "Request should finish.")

        let configuration = Configuration(apiKey: apiKey)
        let service = WebService<OWMResponse>(
            store: StorageService(),
            configuration: configuration
        )
        let request = WebServiceRequest.coordinates(lat: 38.764756879459256, lon: -9.199344190315385)

        service.forecast(request, completion: { result in
            switch result {
            case .error(let errorType):
                XCTAssertNil(errorType)

            case .success(let response):
                XCTAssertTrue(response.isValid)
            }

            anExpectation.fulfill()
        })

        wait(for: [anExpectation], timeout: 5.0)
    }
}
