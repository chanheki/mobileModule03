//
//  ContentView.swift
//  weather_proj
//
//  Created by Chan on 2/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var searchQuery: String = ""
    @State var selection: Int = 1
    @ObservedObject var locationManager: LocationManager
    @StateObject var weatherManager = WeatherManager()
    @State private var showSearchResults = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                BackgroundImageView()
                VStack{
                    TabView(selection: $selection) {
                        navigationTabView(title: "Current", systemImage: "sun.max", view: CurrentlyView(locationManager: locationManager, weatherManager: weatherManager))
                            .background(BackgroundHelper())
                            .tag(1)
                        navigationTabView(title: "Today", systemImage: "cloud.sun", view: TodayView(locationManager: locationManager, weatherManager: weatherManager))
                            .background(BackgroundHelper())
                            .tag(2)
                        navigationTabView(title: "Weekly", systemImage: "calendar", view: WeeklyView(locationManager: locationManager, weatherManager: weatherManager))
                            .background(BackgroundHelper())
                            .tag(3)
                    }
                }
                .navigationBarItems(
                    leading: SearchBar(locationManager: locationManager, showSearchResults: $showSearchResults, searchQuery: $searchQuery),
                    trailing: trailingButton
                )
                .navigationBarTitle("", displayMode: .inline)
                
                if showSearchResults {
                    DynamicHeightList {
                        SearchResultsList(locationManager: locationManager, searchQuery: $searchQuery)
                    }
                    .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height / 8)
                    .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .top)))
                    .zIndex(1)
                    .background(Color(UIColor.systemBackground).opacity(0.8))
                    
                }
            }
        }
    }
    
    var trailingButton: some View {
        HStack {
            if !searchQuery.isEmpty {
                Button(action: {
                    searchQuery = ""
                }) {
                    Image(systemName: "delete.left")
                        .frame(width: 8, height: 8)
                        .padding(8)
                }
            }
            
            Button(action: {
                locationManager.lastLocation = nil
                locationManager.placemark = nil
                locationManager.selectedResult = nil
                locationManager.requestLocation()
            }) {
                Image(systemName: "location")
                    .frame(width: 16, height: 16)
            }
        }
    }
    
    @ViewBuilder
    func navigationTabView<V: View>(title: String, systemImage: String, view: V) -> some View {
        view
            .tabItem {
                Label(title, systemImage: systemImage)
            }
            .onAppear() {
                if let coordinate = locationManager.lastLocation?.coordinate {
                    Task {
                        await weatherManager.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    }
                }
            }
            .onReceive(locationManager.$placemark) { newPlacemark in
                if let newPlacemark = newPlacemark,
                   let coordinate = newPlacemark.location?.coordinate {
                    Task {
                        await weatherManager.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    }
                }
            }
    }
}

#if canImport(UIKit)
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
