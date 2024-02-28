//
//  SearchBarView.swift
//  weather_proj
//
//  Created by Chan on 2/24/24.
//

import SwiftUI

struct SearchBar: View {
    @ObservedObject var locationManager: LocationManager
    @Binding var showSearchResults: Bool
    @Binding var searchQuery: String
    
    @State var currentTaskID: UUID = UUID()
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .frame(width: 16, height: 16)
            
            TextField("Search location...", text: $searchQuery)
                .textFieldStyle(DefaultTextFieldStyle())
                .frame(height: 36)
                .padding(4)
            
            Spacer()
        }
        .onChange(of: searchQuery) { newValue in
            let taskID = UUID()
            currentTaskID = taskID
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                guard taskID == currentTaskID else { return }
                
                if newValue.isEmpty {
                    locationManager.searchResults = []
                    withAnimation {
                        showSearchResults = false
                    }
                } else {
                    locationManager.searchLocations(searchQuery: newValue)
                    withAnimation {
                        showSearchResults = true
                    }
                }
            }
        }
    }
}
