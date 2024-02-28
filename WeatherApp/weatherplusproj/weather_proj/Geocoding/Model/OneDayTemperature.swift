//
//  OneDayTemperature.swift
//  weather_proj
//
//  Created by Chan on 2/28/24.
//

struct OneDayTemperature: Identifiable {
    var temperatureType: String
    var temperature: Float
    var id: String { temperatureType }
}
