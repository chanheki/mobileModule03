//
//  WeeklyView.swift
//  weather_proj
//
//  Created by Chan on 2/5/24.
//

import SwiftUI

struct WeeklyView: View {
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var weatherManager: WeatherManager
    let dateFormatter: DateFormatter
    
    init(locationManager: LocationManager, weatherManager: WeatherManager) {
        self.locationManager = locationManager
        self.weatherManager = weatherManager
        
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
        self.dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    }
    
    var body: some View {
        AdaptiveWeatherView(locationManager: locationManager) {
            VStack {
                PlacemarkView(locationManager: locationManager)

                if let weatherData = weatherManager.weatherData {
                    List {
                        ForEach(Array(weatherData.daily.time.enumerated()), id: \.offset) { index, date in
                            HStack {
                                Text("\(dateFormatter.string(from: date))")
                                Spacer()
                                Text(String(format: "%.1f ℃ ↑", weatherData.daily.temperature2mMax[index]))
                                Spacer()
                                Text(String(format: "%.1f ℃ ↓", weatherData.daily.temperature2mMin[index]))
                                Spacer()
                                Text("\(weatherCodes[Int(weatherData.current.weatherCode)]?.first ?? "Unknown")")
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}
