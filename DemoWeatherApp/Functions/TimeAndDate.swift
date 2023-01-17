//
//  TimeAndDate.swift
//  DemoWeatherApp
//
//  Created by Roberts Kursitis on 07/09/2022.
//

import Foundation

var dayz: [DayModel] = []
var formatter: StringFormatter!

func castDayToModel(data: Properties) -> [DayModel] {
	formatter = StringFormatter()
    var dayArray: [DayModel] = []
    for day in filterOutDays(timeseries: data.timeseries){
        let weekday = timeStringToWeekday(timeString: day.time)
        if day.data.next6Hours != nil {
			dayArray.append(DayModel(dayName: weekday, dayTemp: day.data.instant.details.airTemperature, dayWeatherEmoji: formatter.symbolCodeToEmoji(symbolCode: (day.data.next12Hours?.summary.symbol_code) ?? "")))
        } else {
			dayArray.append(DayModel(dayName: weekday, dayTemp: 0, dayWeatherEmoji: formatter.symbolCodeToEmoji(symbolCode: (day.data.next12Hours?.summary.symbol_code) ?? "")))
        }
    }
    return dayArray
}

func timeStringToReadable(timeString: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .long
    dateFormatter.dateStyle = .short
    return dateFormatter.string(from: timeString)
}

func timeStringToHour(timeString: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter.string(from: timeString)
}

func filterOutDays(timeseries: [Timeseries]) -> [Timeseries] {
    var selections: [Timeseries] = []
    var usedDates: [Int] = []
    for sery in timeseries {
        if(!isDateInList(date: sery.time, list: usedDates)) {
            selections.append(sery)
            usedDates.append(Calendar.current.component(.day, from: sery.time))
        }
    }
    while selections.count > 10 {
        selections.removeLast()
    }
    return selections;
}

func isDateInList(date : Date, list : [Int]) -> Bool {
    let day = Calendar.current.component(.day, from: date)
    for duplicate in list {
        if duplicate == day {
            return true
        }
    }
    if Calendar.current.component(.hour, from: date) < 16 {
        return true
    }
    return false
}

func timeStringToWeekday(timeString: Date) -> String {
    let weekday = Calendar.current.component(.weekday, from: timeString)
    switch weekday {
    case 1: return "Sunday"
    case 2: return "Monday"
    case 3: return "Tuesday"
    case 4: return "Wednesday"
    case 5: return "Thursday"
    case 6: return "Friday"
    case 7: return "Saturday"
    default: return "🤷"
    }
}
