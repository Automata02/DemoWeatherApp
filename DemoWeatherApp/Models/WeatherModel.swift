//
//  WeatherModel.swift
//  DemoWeatherApp
//
//  Created by Roberts Kursitis on 01/09/2022.

import Foundation

//MARK: - WeatherData
struct WeatherData: Codable {
    let type: String
    let geometry: Geometry
    let properties: Properties
}

//MARK: - Geometry
struct Geometry: Codable {
    let type: String
    let coordinates: [Double]
}

//MARK: - Properties
struct Properties: Codable {
    let meta: Meta
    let timeseries: [Timeseries]
}

//MARK: - Meta
struct Meta: Codable {
    let updatedAt: Date
    let units: Units

    enum CodingKeys: String, CodingKey {
        case updatedAt = "updated_at"
        case units
    }
}

//MARK: - Units
struct Units: Codable {
    let airPressureAtSeaLevel, airTemperature, cloudAreaFraction, precipitationAmount: String
    let relativeHumidity, windFromDirection, windSpeed: String

    enum CodingKeys: String, CodingKey {
        case airPressureAtSeaLevel = "air_pressure_at_sea_level"
        case airTemperature = "air_temperature"
        case cloudAreaFraction = "cloud_area_fraction"
        case precipitationAmount = "precipitation_amount"
        case relativeHumidity = "relative_humidity"
        case windFromDirection = "wind_from_direction"
        case windSpeed = "wind_speed"
    }
}

//MARK: - Timeseries
struct Timeseries: Codable {
    let time: Date
    let data: DataClass
}

//MARK: - DataClass
struct DataClass: Codable {
    let instant: Instant
    let next1Hours, next6Hours, next12Hours: NextHours?

    enum CodingKeys: String, CodingKey {
        case next12Hours = "next_12_hours"
        case next1Hours = "next_1_hours"
        case next6Hours = "next_6_hours"
        case instant
    }
}

//MARK: - Instant
struct Instant: Codable {
    let details: InstantDetails
}

//MARK: - InstantDetails
struct InstantDetails: Codable {
    let airPressureAtSeaLevel, airTemperature, cloudAreaFraction, relativeHumidity: Double
    let windFromDirection, windSpeed: Double

    enum CodingKeys: String, CodingKey {
        case airPressureAtSeaLevel = "air_pressure_at_sea_level"
        case airTemperature = "air_temperature"
        case cloudAreaFraction = "cloud_area_fraction"
        case relativeHumidity = "relative_humidity"
        case windFromDirection = "wind_from_direction"
        case windSpeed = "wind_speed"
    }
}

//MARK: - NextHours
struct NextHours: Codable {
    let summary: Summary
    let details: Next1HourDetails?
}

//MARK: - Next1HourDetails
struct Next1HourDetails: Codable {
    let precipitationAmount: Float

    enum CodingKeys: String, CodingKey {
        case precipitationAmount = "precipitation_amount"
    }
}

//MARK: - Summary
struct Summary: Codable {
    let symbol_code: String
}
