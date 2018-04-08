//
//  WeatherData.swift
//  WeatherTeller
//
//  Created by Milja V on 2018-03-28.
//  Copyright © 2018 Milja V. All rights reserved.
//

import Foundation

struct Coord : Codable {
    let lon: Double
    let lat: Double
}

struct Weather : Codable {
    let main: String
    let description: String
    let icon: String
}

struct Main : Codable {
    let temp: Double
}

struct Wind : Codable {
    let speed: Double
}

struct Sys : Codable {
    let country: String
}

struct LocationResponse : Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys
    let id: Int
    let name: String
}

struct UVResponse : Codable {
    let value: Double
}

struct MultipleLocations : Codable {
    let list: [LocationResponse]
}

func calculateRealFeel(location: LocationResponse) -> Double {
    let temp = location.main.temp
    let wind = location.wind.speed
    let twc = 13.12+(0.6215 * temp) - 11.37 * pow(wind, 0.16) + 0.3965 * pow(temp, 0.16)
    return twc
}
