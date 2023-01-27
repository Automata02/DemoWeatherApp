//
//  DemoWeatherAppMockTests.swift
//  DemoWeatherAppMockTests
//
//  Created by roberts.kursitis on 20/01/2023.
//
#warning("TODO: Fix UserDefault testing.")

import XCTest
@testable import DemoWeatherApp

class MockUserDefaults: UserDefaults {
	var userTypeChanged = 0
	override func set(_ value: Int, forKey defaultName: String) {
		if defaultName == "isNewUser" {
			userTypeChanged += 1
		}
	}
}

final class DemoWeatherAppMockTests: XCTestCase {
	var sut: NewUserCheck!
	var mockUserDefaults: MockUserDefaults!

    override func setUpWithError() throws {
		try super.setUpWithError()
		sut = NewUserCheck()
        mockUserDefaults = MockUserDefaults(suiteName: "testing")
    }

    override func tearDownWithError() throws {
        sut = nil
		mockUserDefaults = nil
		try super.tearDownWithError()
    }

	func testUserTypeChange() {
		//given
		//when
		//then
	}
}
