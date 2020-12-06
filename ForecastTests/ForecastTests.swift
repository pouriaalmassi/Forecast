//
//  WebServiceTests.swift
//  WebServiceTests
//
//  Created by Pouria Almassi on 4/12/20.
//

import XCTest
@testable import Forecast

class WebServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNilAPIKeyRequest() throws {
        let anExpectation = expectation(description: "Status code should be 401 provided there is no API key.")

        let configuration = Configuration(apiKey: "")
        let service = WebService<MockResponse>(
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
                    anExpectation.fulfill()

                default:
                    XCTFail()
                }
            default:
                XCTFail()
            }
        })

        wait(for: [anExpectation], timeout: 2.0)
    }

    func testBadRequest() throws {
        let anExpectation = expectation(description: "Status code should be 400 (bad request) provided there is no search term.")

        let configuration = Configuration(apiKey: "95d190a434083879a6398aafd54d9e73")
        let service = WebService<MockResponse>(
            store: StorageService(),
            configuration: configuration
        )
        let request = WebServiceRequest.cityName("")

        service.forecast(request, completion: { result in
            switch result {
            case .error(let error):
                switch error {
                case .clientError(let statusCode):
                    XCTAssertEqual(statusCode, 401)
                    anExpectation.fulfill()

                default:
                    XCTFail()
                }
            default:
                XCTFail()
            }
        })

        wait(for: [anExpectation], timeout: 2.0)
    }

    func testBadRequestPostCode() throws {
        let anExpectation = expectation(description: "Status code should be 400 (bad request) provided there is no search term.")

        let configuration = Configuration(apiKey: "95d190a434083879a6398aafd54d9e73")
        let service = WebService<MockResponse>(
            store: StorageService(),
            configuration: configuration
        )
        let request = WebServiceRequest.postCode("2000")

        service.forecast(request, completion: { result in
            switch result {
            case .error(let error):
                switch error {
                case .clientError(let statusCode):
                    XCTAssertEqual(statusCode, 401)
                    anExpectation.fulfill()

                default:
                    XCTFail()
                }
            default:
                XCTFail()
            }
        })

        wait(for: [anExpectation], timeout: 2.0)
    }
}
