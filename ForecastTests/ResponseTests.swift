//
//  ResponseTests.swift
//  ForecastTests
//
//  Created by Pouria Almassi on 6/12/20.
//

import XCTest
import Foundation
@testable import Forecast

class ResponseTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidResponse() throws {
        let weather = [MockWeather(main: "Snow")]
        let main = MockMain(temp: 10, tempMin: -20, tempMax: 20)
        let response = MockResponse(name: "place", main: main, weather: weather)
        XCTAssertTrue(response.isValid)
        XCTAssertNotNil(response.locationString)
        XCTAssertNotNil(response.forecastString)
        XCTAssertNotNil(response.currentTemperature)
        XCTAssertNotNil(response.minTemperature)
        XCTAssertNotNil(response.maxTemperature)
    }

    func testEmptyWeatherResponse() throws {
        let weather: [MockWeather] = []
        let main = MockMain(temp: 10, tempMin: -20, tempMax: 20)
        let response = MockResponse(name: "place", main: main, weather: weather)
        XCTAssertFalse(response.isValid)
        XCTAssertNil(response.forecastString)
    }

    func testNilWeatherResponse() throws {
        let main = MockMain(temp: 10, tempMin: -20, tempMax: 20)
        let response = MockResponse(name: "place", main: main, weather: nil)
        XCTAssertFalse(response.isValid)
        XCTAssertNil(response.forecastString)
    }

    func testMultipleWeatherResponse() throws {
        let weather = [MockWeather(main: "Snow"), MockWeather(main: "Rain")]
        let main = MockMain(temp: 10, tempMin: -20, tempMax: 20)
        let response = MockResponse(name: "place", main: main, weather: weather)
        XCTAssertTrue(response.isValid)
        XCTAssertNotNil(response.forecastString)
    }

    func testNilNameResponse() throws {
        let weather = [MockWeather(main: "Snow")]
        let main = MockMain(temp: 10, tempMin: -20, tempMax: 20)
        let response = MockResponse(name: nil, main: main, weather: weather)
        XCTAssertFalse(response.isValid)
        XCTAssertNil(response.locationString)
    }

    func testNilTempResponse() throws {
        let weather = [MockWeather(main: "Snow")]
        let main = MockMain(temp: nil, tempMin: -20, tempMax: 20)
        let response = MockResponse(name: "place", main: main, weather: weather)
        XCTAssertFalse(response.isValid)
        XCTAssertNil(response.currentTemperature)
    }

    func testNilMinTempResponse() throws {
        let weather = [MockWeather(main: "Snow")]
        let main = MockMain(temp: 1, tempMin: nil, tempMax: 20)
        let response = MockResponse(name: "place", main: main, weather: weather)
        XCTAssertFalse(response.isValid)
        XCTAssertNil(response.minTemperature)
    }

    func testNilMaxTempResponse() throws {
        let weather = [MockWeather(main: "Snow")]
        let main = MockMain(temp: 1, tempMin: -20, tempMax: nil)
        let response = MockResponse(name: "place", main: main, weather: weather)
        XCTAssertFalse(response.isValid)
        XCTAssertNil(response.maxTemperature)
    }
}
