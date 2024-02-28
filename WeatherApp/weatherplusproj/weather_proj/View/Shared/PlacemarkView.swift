//
//  PlacemarkView.swift
//  weather_proj
//
//  Created by Chan on 2/24/24.
//

import SwiftUI

struct PlacemarkView: View{
    @ObservedObject var locationManager: LocationManager
    
    var body: some View {
        if let placemark = locationManager.placemark {
            if let selectedResult = locationManager.selectedResult {
                Text(selectedResult.name)
                    .bold()
                    .foregroundColor(.blue)
                Text("\(selectedResult.admin1 == nil ? "" : selectedResult.admin1! + ",") \(selectedResult.country)")
            } else {
                Text("\(placemark.locality ?? "")")
                    .bold()
                    .foregroundColor(.blue)
                Text("\(placemark.name == nil ? "" : placemark.name! + ",")" + " \(placemark.country ?? "")")
            }
        } else {
            Text("Fetching location...")
        }
    }
}
