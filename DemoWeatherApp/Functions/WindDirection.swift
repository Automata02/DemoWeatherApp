//
//  WindDirection.swift
//  DemoWeatherApp
//
//  Created by Roberts Kursitis on 05/09/2022.
//

import Foundation

func calculateWindDirection (direction: Double) -> String {
    let degrees = direction * 8 / 360

    if (0...1).contains(degrees) {
        return "North"
    } else if (1...2).contains(degrees) {
        return "North East"
    } else if (2...3).contains(degrees) {
        return "East"
    } else if (3...4).contains(degrees) {
        return "South East"
    } else if (4...5).contains(degrees) {
        return "South"
    } else if (5...6).contains(degrees) {
        return "South West"
    } else if (6...7).contains(degrees) {
        return "West"
    } else if (7...8).contains(degrees) {
        return "North West"
    } else {
        return "balls"
    }
    
}
