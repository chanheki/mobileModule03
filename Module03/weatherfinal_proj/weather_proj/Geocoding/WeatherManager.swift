//
//  WeatherManager.swift
//  weather_proj
//
//  Created by Chan on 2/13/24.
//

import Foundation
import CoreLocation

class WeatherManager: ObservableObject {
    @Published var weatherData: WeatherDataModel?
    @Published var errorMessage: String = ""
    
    private var geocodingAPI = GeocodingAPI()
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async {
        await geocodingAPI.fetchWeatherData(latitude: "\(latitude)", longitude: "\(longitude)") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherData):
                    self.weatherData = weatherData
                case .failure(let error):
                    print("Error fetching weather data: \(error)")
                    self.weatherData = nil
                }
            }
        }
    }
}
