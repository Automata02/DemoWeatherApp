//
//  MapAnnotationExtension.swift
//  DemoWeatherApp
//
//  Created by Roberts Kursitis on 05/09/2022.
//

import Foundation

extension MainViewController: WeatherHandlerDelegate {

    func didFetchSunrise(_ location: [Location]) {
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "HH:mm"
        self.sunrise = location
        let sunriseTime = hourFormatter.string(from: sunrise[0].time[0].sunrise!.time)
        let sunsetTime = hourFormatter.string(from: sunrise[0].time[0].sunset!.time)
        
        DispatchQueue.main.async {
            self.setupSunriseView(date: "Sunrise & Sunset", sunrise: sunriseTime, sunset: sunsetTime)
        }
    }
// MARK: Preparing Data
    func didFetchWeatherForecast(_ timeseries: [Timeseries]) {
        self.weatherForecast = timeseries
        let now = weatherForecast[0].data.instant.details
        let oneHourSymbol = weatherForecast[0].data.next1Hours?.summary.symbol_code ?? "no data"
        let sixHourSymbol = weatherForecast[0].data.next6Hours?.summary.symbol_code ?? "no data"
        let twelveHourSymbol = weatherForecast[0].data.next12Hours?.summary.symbol_code ?? "no data"
        let ppt = weatherForecast[0].data.next1Hours?.details?.precipitationAmount ?? 0
        let temp = String(Int(now.airTemperature.rounded()))
		let subtitle = formatter.symbolCodeToEmoji(symbolCode: oneHourSymbol) + temp
		let caption = formatter.symbolCodeToString(symbolCode: oneHourSymbol)
		let sixHourCaption = formatter.symbolCodeToString(symbolCode: sixHourSymbol)
		let twelveHourCaption = formatter.symbolCodeToString(symbolCode: twelveHourSymbol)
// MARK: Passing Data to collectionView
//       Done in ViewSetupExtension ☹️
// MARK: Placing userLocation Pin
        DispatchQueue.main.async { [self] in
//            if defaults.bool(forKey: "haveNotification") {
//                setupNotification(weather: caption, temp: temp)
//                print("notification will fire at specified time")
//            }
            captionUN = caption
            temperatureUN = now.airTemperature
            
            setupNowView(temp: now.airTemperature,
                              mm: ppt,
                              clouds: now.cloudAreaFraction,
                              humid: now.relativeHumidity,
							  direct: formatter.calculateWindDirection(direction: now.windFromDirection),
                              speed: now.windSpeed)
            setupLaterTodayView(cap: caption, cap6h: sixHourCaption, cap12h: twelveHourCaption)
// MARK: Need to reload data here to fix an issue with Collectionview presenting itself before it has data to build with.
            segmentedCollectionView.collectionView.reloadData()
//MARK: Need a delay for placing pin as sometimes the AnnotationView doesn't become active.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                placePin(here: userLocation, sub: subtitle)
            }
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
