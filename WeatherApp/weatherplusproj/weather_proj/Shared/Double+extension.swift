//
//  Double+extension.swift
//  weather_proj
//
//  Created by Chan on 2/24/24.
//

extension Double {
    var formattedTemperature: String {
        self.formatted(.number.precision(.fractionLength(1)))
    }
}
