//
//  WeatherData.swift
//  WeatherTeller
//
//  Created by Milja V on 2018-03-28.
//  Copyright © 2018 Milja V. All rights reserved.
//

import Foundation

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
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys
    let id: Int
    let name: String
}
