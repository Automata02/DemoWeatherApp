//
//  DemoWeatherAppTimeAndDateFunctionTests.swift
//  DemoWeatherAppTimeAndDateFunctionTests
//
//  Created by roberts.kursitis on 27/01/2023.
//

import XCTest
@testable import DemoWeatherApp

final class DemoWeatherAppTimeAndDateFunctionTests: XCTestCase {
	
	struct MockDate {
		let today: Date!
	}

    override func setUpWithError() throws {
		try super.setUpWithError()
    }

    override func tearDownWithError() throws {
		try super.tearDownWithError()
    }
	
	func testTimeStringtoReadable() throws {
		//given
		var testDay = MockDate(today: Date())
		//when
		var dateComponents = DateComponents()
		dateComponents.year = 2023
		dateComponents.month = 1
		dateComponents.day = 2
		dateComponents.timeZone = TimeZone(abbreviation: "EET")
		dateComponents.hour = 9
		dateComponents.minute = 21
		let userCalendar = Calendar(identifier: .gregorian)
		testDay = MockDate(today: userCalendar.date(from: dateComponents))
		//then
		XCTAssertEqual(timeStringToReadable(timeString: testDay.today), "1/2/23 9:21:00 priekšp. EET", "Something went wrong.")
	}
}
