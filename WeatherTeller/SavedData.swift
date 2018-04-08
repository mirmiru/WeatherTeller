//
//  SavedData.swift
//  WeatherTeller
//
//  Created by Milja V on 2018-04-04.
//  Copyright © 2018 Milja V. All rights reserved.
//

import Foundation

var favoriteIds = UserDefaults.standard.array(forKey: "savedData") as? [Int]
//var array : [LocationResponse]!

var savedData = UserDefaults.standard.array(forKey: "savedData") as? [Int]

func saveData(id: Int) -> Bool {
    if isNewFavorite(id: id) {
        if favoriteIds != nil {
            favoriteIds?.append(id)
        } else {
            favoriteIds = [id]
        }
        UserDefaults.standard.removeObject(forKey: "savedData")
        UserDefaults.standard.set(favoriteIds, forKey: "savedData")
        return true
    }
    return false
}

func isNewFavorite(id: Int) -> Bool {
    if let numbers = UserDefaults.standard.array(forKey: "savedData") as? [Int] {
        for nr in numbers {
            if  nr == id {
                return false
            }
        }
    }
    return true
}

func loadData() -> [Int] {
    if let saved = UserDefaults.standard.array(forKey: "savedData") as? [Int] {
        return saved
    } else {
        return []
    }
}

/*
func loadLocation(id: Int) {
    if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?id=\(id)&units=metric&APPID=7edad7684e284fcb9d65d40572da3930") {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            if let actualError = error {
                print("Error: \(actualError).")
            } else {
                if let actualData = data {
                    let decoder = JSONDecoder()
                    do {
                        let weatherResponse = try decoder.decode(LocationResponse.self, from: actualData)
                        array.append(weatherResponse)
                        print("Array counr: \(array.count)")
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
