//
//  LocationInfoView.swift
//  weather_proj
//
//  Created by Chan on 2/21/24.
//

import SwiftUI
import CoreLocation

struct AdaptiveWeatherView<Content: View>: View {
    @ObservedObject var locationManager: LocationManager
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ZStack {
            if locationManager.lastLocation != nil {
                content()
            } else {
                ZStack {
                    Color.gray.opacity(0.5).edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        Text(locationManager.locationErrorMsg ?? Constant.errorMsg)
                            .padding()
                            .foregroundStyle(.red)
                            .background(Color.white)
                            .cornerRadius(10)
                        Spacer()
                    }
                }
            }
        }
    }
}
