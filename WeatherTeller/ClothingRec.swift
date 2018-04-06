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

func shouldWearSunblock(uv: Double) -> (shouldWear: Bool, spfRecText: String) {
    switch uv {
    case 0...2.9:
        let text = "Low UV Index. If you burn easily, wear SPF 30+."
        return (shouldWear: true, spfRecText: text)
    case 3...5.9:
        print("UV 3-5")
        let text = "Moderate UV Index. Stay in the shade during midday. Apply SPF 30+ every 2 hours. Wear protective clothing and sunglasses."
        return (shouldWear: true, spfRecText: text)
    case 6...7.9:
        let text = "High UV Index. Apply SPF 30+ even if cloudy. Avoid being in the sun between 10 AM-4 PM."
        return (shouldWear: true, spfRecText: text)
    case 8...10.9:
        let text = "Very high UV Index. Apply SPF 30+ even if cloudy every 2 hours. Minimize sun exposure 10 AM-4 PM."
        return (shouldWear: true, spfRecText: text)
    case 11...:
        let text = "Extreme UV Index. Avoid sun exposure 10 AM-4 PM. Generously pply SPF 30+ even if cloudy every 2 hours"
        return (shouldWear: true, spfRecText: text)
    default:
        let text = "No recommendation"
        return (shouldWear: false, spfRecText: text)
    }
}

