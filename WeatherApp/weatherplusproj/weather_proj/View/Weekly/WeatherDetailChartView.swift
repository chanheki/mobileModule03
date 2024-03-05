//
//  WeatherDetailChartView.swift
//  weather_proj
//
//  Created by Chan on 2/27/24.
//

import SwiftUI
import Charts

struct WeatherDetailChartView: View {
    let weeklyData: [WeeklyWeatherData.WeatherSeries]
    @Environment(\.calendar) var calendar
    @Binding var rawSelectedDate: Date?
    @Environment(\.colorScheme) var colorScheme
    
    let symbolSize: CGFloat = 100
    let lineWidth: CGFloat = 2
    
    func endOfDay(for date: Date) -> Date {
        calendar.date(byAdding: .day, value: 1, to: date)!
    }
    
    var selectedDate: Date? {
        if let rawSelectedDate {
            return weeklyData.first?.temperatureData.first(where: {
                let endOfDay = endOfDay(for: $0.day)
                
                return ($0.day ... endOfDay).contains(rawSelectedDate)
            })?.day
        }
        return nil
    }
    
    let colorTemperature: [String: Color] = [
        "Max Temperature": .pink,
        "Min Temperature": .blue
    ]

    var body: some View {
        Chart{
            ForEach(weeklyData) { series in
                ForEach(series.temperatureData, id: \.day) { data in
                    LineMark(
                        x: .value("Day", data.day, unit: .day),
                        y: .value("Temperature", data.temperature)
                    )
                    .foregroundStyle(by: .value("TemperatureType", series.temperatureType))
                    .symbol(by: .value("TemperatureType", series.temperatureType))
                    .interpolationMethod(.catmullRom)
                }
            }

            if let selectedDate {
                RuleMark(
                    x: .value("Selected", selectedDate, unit: .day)
                )
                .foregroundStyle(Color.gray.opacity(0.3))
//                .zIndex(1)
//                .annotation(
//                    position: .top, spacing: 0,
//                    overflowResolution: .init(
//                        x: .fit(to: .chart),
//                        y: .disabled
//                    )
//                ) {
//                    valueSelectionPopover
//                }
            }
        }
        .chartForegroundStyleScale { colorTemperature[$0]! }
        .chartSymbolScale([
            "Max Temperature": Circle().strokeBorder(lineWidth: 2),
            "Min Temperature": Square().strokeBorder(lineWidth: 2)
        ])
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { _ in
                AxisTick()
                AxisGridLine()
                AxisValueLabel(format: .dateTime.weekday(.abbreviated), centered: true)
            }
        }
//        .chartXSelection(value: $rawSelectedDate)
    }

    @ViewBuilder
    var valueSelectionPopover: some View {
        if let selectedDate, let minMaxTemperature = minMaxTemperatureDaily(on: selectedDate) {
                HStack(spacing: 20) {
                    ForEach(minMaxTemperature) { temperatureInfo in
                        HStack(alignment: .lastTextBaseline, spacing: 4) {
                            Text(String(format: "%.1f", temperatureInfo.temperature))
                                .font(.callout)
                                .foregroundColor(colorTemperature[String(temperatureInfo.temperatureType)])
                                .blendMode(colorScheme == .light ? .plusDarker : .normal)
                    }
                }
            }
            .padding(6)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .foregroundStyle(Color(UIColor.systemBackground).opacity(0.8))
            }
        } else {
            EmptyView()
        }
    }
    
    func findIndexForDate(_ selectedDate: Date) -> Int? {
        weeklyData[0].temperatureData.firstIndex { day, _ in
            calendar.isDate(day, equalTo: selectedDate, toGranularity: .weekday)
        }
    }
    
    func minMaxTemperatureDaily(on selectedDate: Date) -> [OneDayTemperature]? {
        guard let index = findIndexForDate(selectedDate) else { return nil }
        
        let minMaxTemperature = weeklyData.map { series -> OneDayTemperature in
            let temperature = series.temperatureData[index].temperature
            return OneDayTemperature(temperatureType: series.temperatureType, temperature: temperature)
        }

        return minMaxTemperature
    }
}
