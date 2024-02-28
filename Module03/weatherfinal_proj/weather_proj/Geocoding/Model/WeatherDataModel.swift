//
//  WeatherDataModel.swift
//  weather_proj
//
//  Created by Chan on 2/6/24.
//

import SwiftUI

struct WeatherDataModel {
    let current: Current
    let hourly: Hourly
    let daily: Daily
    
    struct Current {
        let time: Date
        let temperature2m: Float
        let weatherCode: Float
        let windSpeed10m: Float
    }
    
    struct Hourly {
        let time: [Date]
        let temperature2m: [Float]
        let weatherCode: [Float]
        let windSpeed10m: [Float]
    }
    
    struct Daily {
        let time: [Date]
        let weatherCode: [Float]
        let temperature2mMax: [Float]
        let temperature2mMin: [Float]
    }
}
