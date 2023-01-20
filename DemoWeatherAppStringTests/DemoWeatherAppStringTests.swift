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
	
	//MARK: Wind Direction Function Tests
	func testWindDirection() throws {
		let eastDegrees: Double = 90
		let southWestDegrees: Double = 215.3
		let northDegrees: Double = 339.7
	
		XCTAssertEqual(sut.calculateWindDirection(direction: eastDegrees), "East", "Direction does not match!")
		XCTAssertEqual(sut.calculateWindDirection(direction: southWestDegrees), "South West", "Direction does not match!")
		XCTAssertEqual(sut.calculateWindDirection(direction: northDegrees), "North", "Direction does not match!")
	}
	
	func testWindDirectionPerformance() {
		measure(
			metrics: [XCTClockMetric()]
		) {
			let _ = sut.calculateWindDirection(direction: 351.1)
		}
	}
	
	//MARK: Symbol Code to Emoji Function Tests
	func testSymbolCodeToEmoji() throws {
		//given
		let testString = "rainandthunder"
		
		//when
		let input = sut.symbolCodeToEmoji(symbolCode: testString)
		
		//then
		XCTAssertEqual(input, "⛈️", "Input emoji does not match the functions output.")
	}
	
//	func testSymbolCodeToEmojiPerformance() {
//		measure(
//			metrics: [XCTClockMetric()]
//		) {
//			let _ = sut.symbolCodeToEmoji(symbolCode: "snow")
//		}
//	}
	
	//MARK: Symbol Colde to String Function Tests
	
	func testSymbolCodeToString() throws {
		//given
		let testString = "lightssleetshowersandthunder_day"
		
		//when
		let input = sut.symbolCodeToString(symbolCode: testString)
		
		//then
		XCTAssertEqual(input, "Light sleetshowers and thunder", "Input string does not match the functions output.")
	}
	
//	func testSymbolCodeToStringPerformance() {
//		measure(
//			metrics: [XCTClockMetric()]
//		) {
//			let _ = sut.symbolCodeToString(symbolCode: "snowshowers_day")
//			let _ = sut.symbolCodeToString(symbolCode: "default")
//		}
//	}
}
