//
//  weather_projApp.swift
//  weather_proj
//
//  Created by Chan on 2/5/24.
//

import SwiftUI

@main
struct weather_projApp: App {
    @ObservedObject private var locationManager = LocationManager()
    @Environment(\.scenePhase) private var scenePhase
    
    init() {
        configureNavigationBarAppearance()
        configureTabBarAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(locationManager: locationManager)
                .environmentObject(locationManager)
                .onChange(of: scenePhase) { newPhase in
                    if newPhase == .active {
                        locationManager.requestLocation()
                    }
                }
        }
    }
    
    func configureNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.clear]
        appearance.backgroundColor = UIColor.systemBackground
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        UINavigationBar.appearance().isHidden = true
    }
    
    func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
//        appearance.backgroundImage = UIImage(named: "Background")
        appearance.backgroundColor = .clear
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
