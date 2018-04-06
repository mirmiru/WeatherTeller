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
/*
func getUV(lat: Double, lon: Double) {
    if let url = URL(string: "http://api.openweathermap.org/data/2.5/uvi?appid=7edad7684e284fcb9d65d40572da3930&lat=\(lat)&lon=\(lon)") {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            if let actualError = error {
                print("Error: \(actualError).")
            } else {
                if let actualData = data {
                    let decoder = JSONDecoder()
                    do {
                        let uvResponse = try decoder.decode(UVResponse.self, from: actualData)
                        print("UV Index: \(uvResponse.value)")
                    } catch let error {
                        print("Error parsing JSON: \(error)")
                    }
                } else {
                    print("No data received.")
                }
            }
        })
        task.resume()
    } else {
        print("Bad URL string.")
    }
}
*/
