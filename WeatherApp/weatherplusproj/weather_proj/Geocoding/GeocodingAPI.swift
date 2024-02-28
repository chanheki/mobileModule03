//
//  GeocodingAPI.swift
//  weather_proj
//
//  Created by Chan on 2/7/24.
//

import SwiftUI
import Foundation
import OpenMeteoSdk

class GeocodingAPI {
    func searchLocation(name: String, completion: @escaping (Result<[Location], Error>) -> Void) {
        let baseURL = "https://geocoding-api.open-meteo.com/v1/search"
        let queryItems = [
            URLQueryItem(name: "name", value: name),
            URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "language", value: "en"),
            URLQueryItem(name: "format", value: "json")
        ]
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid response or status code")
                return
            }
            
            guard let data = data else {
                print("Data is missing")
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(GeocodingResponse.self, from: data)
                completion(.success(decodedResponse.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func fetchWeatherData(latitude: String?, longitude: String?, completion: @escaping (Result<WeatherDataModel, Error>) -> Void) async {
        let baseURL = "https://api.open-meteo.com/v1/forecast"
        let queryItems = [
            URLQueryItem(name: "latitude", value: latitude),
            URLQueryItem(name: "longitude", value: longitude),
            URLQueryItem(name: "current", value: "temperature_2m,weather_code,wind_speed_10m"),
            URLQueryItem(name: "hourly", value: "temperature_2m,weather_code,wind_speed_10m"),
            URLQueryItem(name: "daily", value: "weather_code,temperature_2m_max,temperature_2m_min"),
            URLQueryItem(name: "timezone", value: "auto"),
            URLQueryItem(name: "format", value: "flatbuffers"),
            URLQueryItem(name: "forecast_days", value: "7")
        ]
        
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completion(.failure(NSError(domain: "URL Error", code: -1, userInfo: nil)))
            return
        }
        
        do {
            let responses = try await WeatherApiResponse.fetch(url: url)
            if let response = responses.first {
                let utcOffsetSeconds = response.utcOffsetSeconds
                let current = response.current!
                let hourly = response.hourly!
                let daily = response.daily!
                
                let weatherDataModel = WeatherDataModel(
                    current: .init(
                        time: Date(timeIntervalSince1970: TimeInterval(current.time + Int64(utcOffsetSeconds))),
                        temperature2m: current.variables(at: 0)!.value,
                        weatherCode: current.variables(at: 1)!.value,
                        windSpeed10m: current.variables(at: 2)!.value
                    ),
                    hourly: .init(
                        time: hourly.getDateTime(offset: utcOffsetSeconds),
                        temperature2m: hourly.variables(at: 0)!.values,
                        weatherCode: hourly.variables(at: 1)!.values,
                        windSpeed10m: hourly.variables(at: 2)!.values
                    ),
                    daily: .init(
                        time: daily.getDateTime(offset: utcOffsetSeconds),
                        weatherCode: daily.variables(at: 0)!.values,
                        temperature2mMax: daily.variables(at: 1)!.values,
                        temperature2mMin: daily.variables(at: 2)!.values
                    )
                )
                completion(.success(weatherDataModel))
            } else {
                completion(.failure(NSError(domain: "Data Error", code: -4, userInfo: nil)))
            }
        } catch {
            completion(.failure(error))
        }
    }
}
