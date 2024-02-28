//
//  WeeklyDescriptionView.swift
//  weather_proj
//
//  Created by Chan on 2/28/24.
//

import SwiftUI

struct WeeklyDescriptionView: View {
    @ObservedObject var weatherManager: WeatherManager
    
    let dateFormatter: DateFormatter
    
    init(weatherManager: WeatherManager) {
        self.weatherManager = weatherManager
        
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
        self.dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    }
    
    var body: some View {
        if let weatherData = weatherManager.weatherData {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(Array(weatherData.daily.time.enumerated()), id: \.offset) { index, date in
                        VStack {
                            Text("\(dateFormatter.string(from: date))")
                                .padding()
                            Image(systemName: weatherCodes[Int(weatherData.hourly.weatherCode[index])]?.last ?? "")
                                .symbolRenderingMode(.hierarchical)
                                .font(.title)
                                .foregroundStyle(.blue)
                                .padding()
                            Text(String(format: "%.1f ℃ ↑", weatherData.daily.temperature2mMax[index]))
                                .foregroundColor(.pink)
                            Text(String(format: "%.1f ℃ ↓", weatherData.daily.temperature2mMin[index]))
                                .foregroundColor(.blue)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}
