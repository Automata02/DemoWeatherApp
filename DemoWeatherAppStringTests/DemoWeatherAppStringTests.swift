//
//  DemoWeatherAppStringTests.swift
//  DemoWeatherAppStringTests
//
//  Created by roberts.kursitis on 17/01/2023.
//

import XCTest
@testable import DemoWeatherApp

final class DemoWeatherAppStringTests: XCTestCase {
	var sut: StringFormatter!

    override func setUpWithError() throws {
		try super.setUpWithError()
		sut = StringFormatter()
    }

    override func tearDownWithError() throws {
		sut = nil
        try super.tearDownWithError()
    }
	
	func testWindDirection() throws {
		let eastDegrees: Double = 90
		let southWestDegrees: Double = 215.3
		let northDegrees: Double = 339.7
	
		XCTAssertEqual(sut.calculateWindDirection(direction: eastDegrees), "East", "Direction does not match!")
		XCTAssertEqual(sut.calculateWindDirection(direction: southWestDegrees), "South West", "Direction does not match!")
		XCTAssertEqual(sut.calculateWindDirection(direction: northDegrees), "North", "Direction does not match!")
	}
	
//	func testWindDirectionPerformance() {
//		measure(
//			metrics: [
//				XCTClockMetric(),
//				XCTCPUMetric(),
//				XCTStorageMetric(),
//				XCTMemoryMetric()
//			]
//		) {
//			let output = sut.calculateWindDirection(direction: 351.1)
//		}
//	}
}
