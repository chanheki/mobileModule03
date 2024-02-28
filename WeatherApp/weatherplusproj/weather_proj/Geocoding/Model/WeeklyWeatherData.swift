//
//  WeeklyWeatherData.swift
//  weather_proj
//
//  Created by Chan on 2/26/24.
//

import SwiftUI

struct WeeklyWeatherData {
    struct WeatherSeries: Identifiable {
        let temperatureType: String // 온도 타입
        let temperatureData: [(day: Date, temperature: Float)]
        var id: String { temperatureType }
    }
    
    static func convertFrom(weatherDataModel: WeatherDataModel, temperatureType: String) -> [WeatherSeries] {
        var maxTemperatureSeries: [WeatherSeries] = []
        var minTemperatureSeries: [WeatherSeries] = []
        
        let maxTemperatureData = weatherDataModel.daily.time.indices.map { index in
            (day: weatherDataModel.daily.time[index], temperature: weatherDataModel.daily.temperature2mMax[index])
        }
        maxTemperatureSeries.append(WeatherSeries(temperatureType: "Max Temperature", temperatureData: maxTemperatureData))
        
        let minTemperatureData = weatherDataModel.daily.time.indices.map { index in
            (day: weatherDataModel.daily.time[index], temperature: weatherDataModel.daily.temperature2mMin[index])
        }
        minTemperatureSeries.append(WeatherSeries(temperatureType: "Min Temperature", temperatureData: minTemperatureData))
        
        switch temperatureType {
        case "Max Temperature":
            return maxTemperatureSeries
        case "Min Temperature":
            return minTemperatureSeries
        default:
            return maxTemperatureSeries + minTemperatureSeries
        }
    }
    
    static func date(year: Int, month: Int, day: Int = 1) -> Date {
        Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) ?? Date()
    }
    
    // Mock data
    static let weeklydata: [WeatherSeries] = [
        .init(temperatureType: "Max Temperature", temperatureData: [
            (day: date(year: 2022, month: 5, day: 2), temperature: Float(15.3)),
            (day: date(year: 2022, month: 5, day: 3), temperature: Float(6.2)),
            (day: date(year: 2022, month: 5, day: 4), temperature: Float(19.1)),
            (day: date(year: 2022, month: 5, day: 5), temperature: Float(15.4)),
            (day: date(year: 2022, month: 5, day: 6), temperature: Float(4.5)),
            (day: date(year: 2022, month: 5, day: 7), temperature: Float(11)),
            (day: date(year: 2022, month: 5, day: 8), temperature: Float(19.9))
            ]),
        .init(temperatureType: "Min Temperature", temperatureData: [
            (day: date(year: 2022, month: 5, day: 2), temperature: Float(5.3)),
            (day: date(year: 2022, month: 5, day: 3), temperature: Float(-6.2)),
            (day: date(year: 2022, month: 5, day: 4), temperature: Float(9.1)),
            (day: date(year: 2022, month: 5, day: 5), temperature: Float(-15.4)),
            (day: date(year: 2022, month: 5, day: 6), temperature: Float(-4.5)),
            (day: date(year: 2022, month: 5, day: 7), temperature: Float(-11)),
            (day: date(year: 2022, month: 5, day: 8), temperature: Float(9.9))
            ]),
    ]
}
