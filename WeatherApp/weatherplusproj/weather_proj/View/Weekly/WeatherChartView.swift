//
//  WeatherChartView.swift
//  weather_proj
//
//  Created by Chan on 2/26/24.
//

import SwiftUI
import Charts

struct WeatherChartView: View {
    @ObservedObject var weatherManager: WeatherManager
    @Environment(\.calendar) var calendar
    @State var rawSelectedDate: Date? = nil
    
    private var weeklyData: [WeeklyWeatherData.WeatherSeries] {
        prepareWeeklyData()
    }
    
    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 1) {
                Spacer(minLength: 6)
                WeatherDetailChartView(weeklyData: weeklyData, rawSelectedDate: $rawSelectedDate)
                    .frame(height: 240)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
    
    private func prepareWeeklyData() -> [WeeklyWeatherData.WeatherSeries] {
        guard let weatherData = weatherManager.weatherData else { return [] }
        
        let maxTemperatureSeries = WeeklyWeatherData.WeatherSeries(
            temperatureType: "Max Temperature",
            temperatureData: weatherData.daily.time.indices.map { index in
                (day: weatherData.daily.time[index], temperature: weatherData.daily.temperature2mMax[index])
            }
        )
        
        let minTemperatureSeries = WeeklyWeatherData.WeatherSeries(
            temperatureType: "Min Temperature",
            temperatureData: weatherData.daily.time.indices.map { index in
                (day: weatherData.daily.time[index], temperature: weatherData.daily.temperature2mMin[index])
            }
        )
        
        return [maxTemperatureSeries, minTemperatureSeries]
    }
}
