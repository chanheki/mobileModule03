//
//  CurrentlyDetailView.swift
//  weather_proj
//
//  Created by Chan on 2/24/24.
//

import SwiftUI

struct CurrentlyDetailView: View {
    @ObservedObject var weatherManager: WeatherManager
    
    var body: some View {
        if let weatherData = weatherManager.weatherData {
            Text(String(format: "%.1f ℃", weatherData.current.temperature2m))
                .font(.largeTitle)
                .foregroundStyle(.orange)
                .padding()
            
            VStack {
                Text("\(weatherCodes[Int(weatherData.current.weatherCode)]?.first ?? "Unknown")")
                    .font(.subheadline)
                    .padding()
                Image(systemName: weatherCodes[Int(weatherData.current.weatherCode)]?.last ?? "" )
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.blue)
                    .font(.largeTitle)
            }
            .padding()
            
            HStack {
                Image(systemName: "wind")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.blue)
                
                Text(String(format: "%.1f km/h", weatherData.current.windSpeed10m))
                    .font(.callout)
            }
            .padding()
        }
    }
}
