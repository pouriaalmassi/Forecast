//
//  ExtensionTests.swift
//  ForecastTests
//
//  Created by Pouria Almassi on 5/12/20.
//

import XCTest
@testable import Forecast

class ExtensionTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStringIsBlank() throws {
        XCTAssertTrue("".isBlank)
        XCTAssertTrue(" ".isBlank)
        XCTAssertFalse("abc".isBlank)
    }

    func testStringIsNumeric() throws {
        XCTAssertTrue("1234".isNumeric)
        XCTAssertFalse("abc".isNumeric)
        XCTAssertFalse(".?!".isNumeric)
        XCTAssertFalse(" ".isNumeric)
    }

    func testDecimalTemperatureString() throws {
        XCTAssertEqual(Decimal(-1).temperatureString, "-1°")
        XCTAssertEqual(Decimal(-1.0).temperatureString, "-1°")
        XCTAssertEqual(Decimal(0).temperatureString, "0°")
        XCTAssertEqual(Decimal(0.0).temperatureString, "0°")
        XCTAssertEqual(Decimal(1).temperatureString, "1°")
        XCTAssertEqual(Decimal(1.0).temperatureString, "1°")
    }
}
