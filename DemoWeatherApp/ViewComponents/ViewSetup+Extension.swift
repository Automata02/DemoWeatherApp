//
//  ViewSetupExtension.swift
//  DemoWeatherApp
//
//  Created by Roberts Kursitis on 05/09/2022.
//

import Foundation
import UIKit

extension MainViewController: UICollectionViewDataSource {
    
    func setupNowView(temp: Double, mm: Float, clouds: Double, humid: Double, direct: String, speed: Double) {
        weatherNowOutlet.currentTempLabel.text = String(temp) + "°"
        if mm == 0.0 {
            weatherNowOutlet.pptLabel.text = "None"
        } else {
            weatherNowOutlet.pptLabel.text = String(mm) + "mm"
        }
        weatherNowOutlet.cloudsLabel.text = String(clouds) + "%"
        weatherNowOutlet.humidityLabel.text = String(humid) + "%"
        weatherNowOutlet.windDirection.text = direct
        weatherNowOutlet.windSpeedLabel.text = String(speed) + " m/s"
    }
    
    func setupLaterTodayView(cap: String, cap6h: String, cap12h: String) {
        weatherLaterOutlet.nextHourLabel.text = cap
        weatherLaterOutlet.nextSixHoursLabel.text = cap6h
        weatherLaterOutlet.nextTwelveHoursLabel.text = cap12h
    }
    
    func setupSunriseView(date: String, sunrise: String, sunset: String) {
        sunriseOutlet.dateLabel.text = date
        sunriseOutlet.sunriseLabel.text = sunrise
        sunriseOutlet.sunsetLabel.text = sunset
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmentedCollectionView.segmentSwitch.selectedSegmentIndex == 0 {
            if weatherForecast.isEmpty {
                return 0
            } else if weatherForecast.count >= 24 {
                return 24
            } else {
                return 0
            }
        } else {
            return dayz.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        if segmentedCollectionView.segmentSwitch.selectedSegmentIndex == 0 {
            let hour = weatherForecast[indexPath.row]
            let firstHour = weatherForecast[indexPath.first!]
			cell.configure(time: timeStringToHour(timeString: hour.time), emoji: formatter.symbolCodeToEmoji(symbolCode: hour.data.next1Hours?.summary.symbol_code ?? ""), temp: hour.data.instant.details.airTemperature)
            for _ in weatherForecast {
                if hour.time == firstHour.time {
					cell.configure(time: "Now", emoji: formatter.symbolCodeToEmoji(symbolCode: hour.data.next1Hours?.summary.symbol_code ?? ""), temp: hour.data.instant.details.airTemperature)
                }
            }
        } else {
            let item = dayz[indexPath.row]
            cell.configure(time: item.dayName, emoji: item.dayWeatherEmoji, temp: item.dayTemp)
        }
        return cell
    }
}
