//
//  SunStateModel.swift
//  DemoWeatherApp
//
//  Created by Roberts Kursitis on 08/09/2022.
//
//   let sunStateModel = try? newJSONDecoder().decode(SunStateModel.self, from: jsonData)

import Foundation

// MARK: - SunStateModel
struct SunStateModel: Codable {
    let location: Location
}

// MARK: - Location
struct Location: Codable {
    let height, latitude, longitude: String
    let time: [Time]
}

// MARK: - Time
struct Time: Codable {
    let date: String
    let highMoon, lowMoon: HighMoon?
    let moonphase: Moonphase?
    let moonposition: Moonposition
    let moonrise, moonset: Moonrise?
    let moonshadow, solarmidnight, solarnoon: HighMoon?
    let sunrise, sunset: Moonrise?

    enum CodingKeys: String, CodingKey {
        case date
        case highMoon = "high_moon"
        case lowMoon = "low_moon"
        case moonphase, moonposition, moonrise, moonset, moonshadow, solarmidnight, solarnoon, sunrise, sunset
    }
}

// MARK: - HighMoon
struct HighMoon: Codable {
    let desc, elevation: String
    let time: Date
    let azimuth: String?
}

// MARK: - Moonphase
struct Moonphase: Codable {
    let desc: String
    let time: Date
    let value: String
}

// MARK: - Moonposition
struct Moonposition: Codable {
    let azimuth, desc, elevation, phase: String
    let range: String
    let time: Date
}

// MARK: - Moonrise
struct Moonrise: Codable {
    let desc: String
    let time: Date
}
