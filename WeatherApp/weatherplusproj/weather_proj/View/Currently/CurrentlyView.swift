//
//  Currently.swift
//  weather_proj
//
//  Created by Chan on 2/5/24.
//

import SwiftUI
import CoreLocation

struct CurrentlyView: View {
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var weatherManager: WeatherManager
    
    init(locationManager: LocationManager, weatherManager: WeatherManager) {
        self.locationManager = locationManager
        self.weatherManager = weatherManager
    }
    
    var body: some View {
        AdaptiveWeatherView(locationManager: locationManager) {
            VStack {
                PlacemarkView(locationManager: locationManager)
                CurrentlyDetailView(weatherManager: weatherManager)
            }
            .padding()
        }
    }
}
