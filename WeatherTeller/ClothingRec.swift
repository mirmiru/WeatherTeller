//
//  ClothingRec.swift
//  WeatherTeller
//
//  Created by Milja V on 2018-04-05.
//  Copyright © 2018 Milja V. All rights reserved.
//

import Foundation

func shouldBringSweather(temp: Double) -> Bool {
    if temp < 10.0 {
        return true
    } else {
        return false
    }
}

func shouldBringMittens(temp: Double) -> Bool {
    if temp < 5 {
        return true
    } else {
        return false
    }
}

func shouldWearSunblock(uv: Double) -> Bool {
    if uv < 3 {
        return false
    } else {
        return true
    }
}
