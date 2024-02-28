//
//  Constant.swift
//  weather_proj
//
//  Created by Chan on 2/22/24.
//

struct Constant {
    static let errorMsg: String = "Geolocation is not available, please enable it in your App settings"
    
    struct locationError {
        static let locationUnknown: String = "Location data unavailable"
        static let network: String = "Network connection is lost"
        static let denied: String = "Location services denied by the user"
    }
    
    struct searchError {
        static let dataMissing: String = "Could not find any result for the supplied address or coordinates."
        static let network: String = "The service connection is lost. please check your internet connection or try again later"
    }
}
