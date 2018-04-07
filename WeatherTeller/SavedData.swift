//
//  SavedData.swift
//  WeatherTeller
//
//  Created by Milja V on 2018-04-04.
//  Copyright © 2018 Milja V. All rights reserved.
//

import Foundation

var favoriteIds : [Int]?
var savedData = UserDefaults.standard.array(forKey: "savedData") as? [Int]

func saveData(id: Int) {
    if isNewFavorite(id: id) {
        favoriteIds = loadData()
        favoriteIds?.append(id)
        print("New favorite.")
        UserDefaults.standard.removeObject(forKey: "savedData")
        UserDefaults.standard.set(favoriteIds, forKey: "savedData")
    }
    print(loadData())
}

func isNewFavorite(id: Int) -> Bool {
    if let fav = UserDefaults.standard.array(forKey: "savedData") as? [Int] {
        for i in fav {
            if i == id {
                print("Already saved.")
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
