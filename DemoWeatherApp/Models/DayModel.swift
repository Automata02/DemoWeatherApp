//
//  DayModel.swift
//  DemoWeatherApp
//
//  Created by Roberts Kursitis on 07/09/2022.
//

import Foundation

struct DayModel {
    public var dayName: String
    public var dayWeatherEmoji: String
    public var dayTemp: Double
    
    init(dayName: String, dayTemp: Double, dayWeatherEmoji: String) {
        self.dayName = dayName
        self.dayTemp = dayTemp
        self.dayWeatherEmoji = dayWeatherEmoji
    }
}
