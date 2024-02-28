//
//  GeocodingModel.swift
//  weather_proj
//
//  Created by Chan on 2/7/24.
//

import Foundation

// API 응답을 위한 모델 정의
struct GeocodingResponse: Codable {
    var results: [Location]
}

struct Location: Codable, Identifiable {
    var id: Int
    var name: String
    var latitude: Double
    var longitude: Double
    var elevation: Double
    var featureCode: String
    var countryCode: String
    var timezone: String
    var country: String
    var countryId: Int
    var population: Int?
    var postcodes: [String]?
    var admin1: String?
    var admin2: String?
    var admin3: String?
    var admin4: String?
    var admin1_id: Int?
    var admin2_id: Int?
    var admin3_id: Int?
    var admin4_id: Int?
    
    // JSON 필드명과 Swift 프로퍼티 이름 매핑
    private enum CodingKeys: String, CodingKey {
        case id, name, latitude, longitude, elevation, timezone, country, population, postcodes, admin1, admin2, admin3, admin4, admin1_id, admin2_id, admin3_id, admin4_id
        case featureCode = "feature_code"
        case countryCode = "country_code"
        case countryId = "country_id"
    }
}

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id
    }
}
