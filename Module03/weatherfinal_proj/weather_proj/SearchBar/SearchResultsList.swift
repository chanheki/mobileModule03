//
//  SearchResultsList.swift
//  weather_proj
//
//  Created by Chan on 2/24/24.
//

import SwiftUI
import CoreLocation

struct SearchResultsList: View {
    @ObservedObject var locationManager: LocationManager
    @Binding var searchQuery: String
    
    var body: some View {
        Group {
            if locationManager.searchResults.isEmpty {
                HStack {
                    Text("No search results found.")
                        .padding()
                }
            } else {
                LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                    ForEach(locationManager.searchResults, id: \.id) { location in
                        Button(action: {
                            searchQuery = ""
                            UIApplication.shared.endEditing()
                            
                            let clLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
                            locationManager.lastLocation = clLocation
                            locationManager.fetchPlacemark(for: clLocation)
                            locationManager.selectedResult = location
                        }) {
                            let locationName: String = "\(location.name), "
                            let locationAdmin: String = location.admin1 == nil ? "" : "\(location.admin1!), "
                            let locationCountry: String = "\(location.country)"
                            highlightSearchResult(fullText: locationName + locationAdmin + locationCountry, query: searchQuery)
                        }
                        .padding(.vertical, 5)
                        Divider()
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10)
    ]
    
    func highlightSearchResult(fullText: String, query: String) -> Text {
        guard !query.isEmpty, let range = fullText.range(of: query, options: .caseInsensitive) else {
            return Text(fullText).foregroundColor(.black)
        }
        
        let beforeQuery = String(fullText[..<range.lowerBound])
        let queryText = String(fullText[range])
        let afterQuery = String(fullText[range.upperBound...])
        
        return Text(beforeQuery).foregroundColor(.primary) + Text(queryText).bold().foregroundColor(.blue) + Text(afterQuery).foregroundColor(.primary)
    }
}
