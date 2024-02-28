//
//  WeeklyDetailView.swift
//  weather_proj
//
//  Created by Chan on 2/25/24.
//

import SwiftUI

struct WeeklyDetailView: View {
    @ObservedObject var weatherManager: WeatherManager
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    WeatherChartView(weatherManager: weatherManager)
                        .frame(width: geometry.size.width, height: 300)
                    
                    Spacer(minLength: 15)
                    
                    WeeklyDescriptionView(weatherManager: weatherManager)
                }
                .frame(width: geometry.size.width)
            }
            
        }
    }
}
