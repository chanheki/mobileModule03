//
//  WMO.swift
//  weather_proj
//
//  Created by Chan on 2/13/24.
//


// MARK: WMO Weather interpretation codes (WW)

//Code    Description
//0    Clear sky
//1, 2, 3    Mainly clear, partly cloudy, and overcast
//45, 48    Fog and depositing rime fog
//51, 53, 55    Drizzle: Light, moderate, and dense intensity
//56, 57    Freezing Drizzle: Light and dense intensity
//61, 63, 65    Rain: Slight, moderate and heavy intensity
//66, 67    Freezing Rain: Light and heavy intensity
//71, 73, 75    Snow fall: Slight, moderate, and heavy intensity
//77    Snow grains
//80, 81, 82    Rain showers: Slight, moderate, and violent
//85, 86    Snow showers slight and heavy
//95 *    Thunderstorm: Slight or moderate
//96, 99 *    Thunderstorm with slight and heavy hail
//(*) Thunderstorm forecast with hail is only available in Central Europe
//

let weatherCodes: [Int: [String]] = [
    0: ["Clear sky", "sun.max"],
    1: ["Mainly clear","sun.min"],
    2: ["Partly cloudy", "cloud.sun"],
    3: ["Overcast", "cloud"],
    45: ["Fog", "cloud.fog"],
    48: ["Depositing rime fog", "sun.dust"],
    51: ["Drizzle: Light intensity", "cloud.drizzle"],
    53: ["Drizzle: Moderate intensity","cloud.drizzle"],
    55: ["Drizzle: Dense intensity", "cloud.drizzle"],
    56: ["Freezing Drizzle: Light intensity", "cloud.drizzle.fill"],
    57: ["Freezing Drizzle: Dense intensity", "cloud.drizzle.fill"],
    61: ["Rain: Slight intensity", "cloud.sun.rain"],
    63: ["Rain: Moderate intensity", "cloud.rain"],
    65: ["Rain: Heavy intensity", "cloud.heavyrain"],
    66: ["Freezing Rain: Light intensity", "cloud.rain"],
    67: ["Freezing Rain: Heavy intensity", "cloud.rain"],
    71: ["Snow fall: Slight intensity", "wind.snow"],
    73: ["Snow fall: Moderate intensity", "cloud.snow"],
    75: ["Snow fall: Heavy intensity", "cloud.snow"],
    77: ["Snow grains", "snowflake"],
    80: ["Rain showers: Slight intensity", "cloud.rain.fill"],
    81: ["Rain showers: Moderate intensity", "cloud.rain.fill"],
    82: ["Rain showers: Violent intensity", "cloud.rain.fill"],
    85: ["Snow showers slight", "cloud.snow"],
    86: ["Snow showers heavy", "cloud.snow.fill"],
    95: ["Thunderstorm: Slight or moderate", "cloud.sun.bolt.fill"],
    96: ["Thunderstorm with slight hail", "cloud.hail"],
    99: ["Thunderstorm with heavy hail", "cloud.bolt.rain.fill"]
]
