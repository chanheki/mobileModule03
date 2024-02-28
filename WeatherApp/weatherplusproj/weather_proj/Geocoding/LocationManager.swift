//
//  LocationManager.swift
//  weather_proj
//
//  Created by Chan on 2/5/24.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let coreLocationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    @Published var placemark: CLPlacemark?
    @Published var searchResults: [Location] = []
    @Published var selectedResult: Location?
    @Published var locationErrorMsg: String?
    
    override init() {
        super.init()
        self.coreLocationManager.delegate = self
        self.coreLocationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        fetchPlacemark(for: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        lastLocation = nil
        placemark = nil
        selectedResult = nil
        
        guard let clError = error as? CLError else {
            print("Unknown error: \(error)")
            locationErrorMsg = "Unknown error: \(error)"
            return
        }
        
        switch clError.code {
        case .locationUnknown:
            // 위치 정보를 가져올 수 없음
            print("Location data unavailable")
            locationErrorMsg = Constant.locationError.locationUnknown
        case .network:
            // 네트워크 연결 문제
            print("Network connection is lost")
            locationErrorMsg = Constant.locationError.network
        case .denied:
            // 위치 서비스에 대한 액세스가 거부됨
            print("Location services denied by the user")
            locationErrorMsg = Constant.locationError.denied
        default:
            print("Location error: \(error.localizedDescription)")
            locationErrorMsg = "Location error: \(error.localizedDescription)"
        }
    }
    
    func requestLocation() {
        placemark = nil
        coreLocationManager.requestWhenInUseAuthorization()
        coreLocationManager.requestLocation()
    }
    
    func fetchPlacemark(for location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            if let error = error {
                print("Geocoding error: \(error)")
                return
            }
            self?.placemark = placemarks?.first
        }
    }
    
    func searchLocations(searchQuery: String) {
        let api = GeocodingAPI()
        api.searchLocation(name: searchQuery) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let locations):
                    self?.searchResults = locations.map { $0 }
                case .failure(let error):
                    self?.lastLocation = nil
                    self?.placemark = nil
                    self?.selectedResult = nil
                    
                    if error.localizedDescription.contains("The data couldn’t be read because it is missing.") {
                        self?.locationErrorMsg = Constant.searchError.dataMissing
                    } else if error.localizedDescription.contains("The Internet connection appears to be offline."){
                        self?.locationErrorMsg = Constant.searchError.network
                    } else {
                        self?.locationErrorMsg = error.localizedDescription
                    }
                    
                    print(error.localizedDescription)
                    return
                }
            }
        }
    }
}
