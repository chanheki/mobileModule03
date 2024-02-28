//
//  TodayDetailView.swift
//  weather_proj
//
//  Created by Chan on 2/24/24.
//

import SwiftUI
import Charts

struct TodayDetailView: View {
    @ObservedObject var weatherManager: WeatherManager
    let dateFormatter: DateFormatter
    let temperatureFormatter: Decimal.FormatStyle
    var chartDateFormatter: Date.FormatStyle
    
    init(weatherManager: WeatherManager) {
        self.weatherManager = weatherManager
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "HH:mm"
        self.dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        self.temperatureFormatter = Decimal.FormatStyle.number.precision(.fractionLength(1))
        self.chartDateFormatter = Date.FormatStyle().hour(.defaultDigits(amPM: .omitted)).minute(.defaultDigits)
        if let timezone = TimeZone(secondsFromGMT: 0) {
            self.chartDateFormatter.timeZone = timezone
        }
    }
    
    var body: some View {
        if let weatherData = weatherManager.weatherData {
            ScrollView {
                VStack {
                    Chart {
                        ForEach(Array(weatherData.hourly.time.enumerated()), id: \.element) { (index, time) in
                            LineMark(
                                x: .value("Time", time),
                                y: .value("Temperature", weatherData.hourly.temperature2m[index])
                            )
                            PointMark(
                                x: .value("Time", time),
                                y: .value("Temperature", weatherData.hourly.temperature2m[index])
                            )
                        }
                    }
                    .chartXAxis {
                        AxisMarks(preset: .aligned, position: .bottom) { _ in
                            AxisGridLine()
                            AxisValueLabel(format: chartDateFormatter.hour().minute(.defaultDigits), centered: false)
                        }
                    }
                    .chartYAxis {
                        AxisMarks(preset: .aligned, position: .leading) { _ in
                            AxisGridLine()
                            AxisValueLabel(format: temperatureFormatter)
                        }
                    }
                    .frame(height: 300)
                    .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(Array(weatherData.hourly.time.enumerated()), id: \.offset) { index, date in
                                VStack {
                                    Text("\(dateFormatter.string(from: date))")
                                        .padding()

                                    Image(systemName: weatherCodes[Int(weatherData.hourly.weatherCode[index])]?.last ?? "")
                                        .symbolRenderingMode(.hierarchical)
                                        .font(.title)
                                        .foregroundStyle(.blue)
                                        .padding()

                                    Text(String(format: "%.1f ℃", weatherData.hourly.temperature2m[index]))
                                        .foregroundStyle(.orange)
                                        .font(.title2)
                                        .padding()

                                    HStack {
                                        Image(systemName: "wind")
                                            .symbolRenderingMode(.hierarchical)
                                            .foregroundStyle(.blue)

                                        Text(String(format: "%.1f km/h", weatherData.hourly.windSpeed10m[index]))
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
        } else {
            Text("Loading weather information...")
        }
    }
}
