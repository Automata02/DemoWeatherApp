//
//  WeatherHandler.swift
//  DemoWeatherApp
//
//  Created by Roberts Kursitis on 01/09/2022.
//

import Foundation
import CoreLocation

protocol WeatherHandlerDelegate {
    func didFetchWeatherForecast(_ timeseries: [Timeseries])
    func didFetchSunrise(_ location: [Location])
    func didFailWithError(error: Error)
}

struct WeatherHandler {
    let weatherURL = "https://api.met.no/weatherapi/locationforecast/2.0/compact"
    let sunURL = "https://api.met.no/weatherapi/sunrise/2.0/.json"
    var delegate: WeatherHandlerDelegate?
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let today = Date.now.ISO8601Format(.iso8601.year().month().day())
        let urlString = "\(weatherURL)?lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
        let sunUrlString = "\(sunURL)?lat=\(latitude)&lon=\(longitude)&date=\(today)&offset=+02:00"
        performSunriseRequest(with: sunUrlString)
    }
	
    func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else {return}

        var request = URLRequest(url: url)
        request.setValue("DemoWeatherApp/1.0 github.com/Automata02/DemoWeatherApp", forHTTPHeaderField: "User-Agent")
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        URLSession(configuration: config).dataTask(with: request) { (data, response, error) in
            if error != nil {
                print((error?.localizedDescription)!)
            }
            guard let data = data else {
                print(error as Any)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let weatherData = try decoder.decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    dayz = castDayToModel(data: weatherData.properties)
                }
                self.delegate?.didFetchWeatherForecast(weatherData.properties.timeseries)
            } catch {
                print("Error: ", error as Any)
            }
        } .resume()
    }
    
    func performSunriseRequest(with sunUrlString: String) {
        guard let url = URL(string: sunUrlString) else {return}

        var request = URLRequest(url: url)
        request.setValue("DemoWeatherApp/1.0 github.com/Automata02/DemoWeatherApp", forHTTPHeaderField: "User-Agent")
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        URLSession(configuration: config).dataTask(with: request) { (data, response, error) in
            if error != nil {
                print((error?.localizedDescription)!)
            }
            guard let data = data else {
                print(error as Any)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let sunData = try decoder.decode(SunStateModel.self, from: data)
                self.delegate?.didFetchSunrise([sunData.location])
            } catch {
                print("Error: ", error as Any)
            }
        } .resume()
    }
}
