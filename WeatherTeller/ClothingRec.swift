//
//  ClothingRec.swift
//  WeatherTeller
//
//  Created by Milja V on 2018-04-05.
//  Copyright © 2018 Milja V. All rights reserved.
//

import Foundation

func shouldBringSweather(temp: Double) -> Bool {
    switch temp {
    case 0...10:
        return true
    default:
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
    case 0...2.99:
        let text = String(format: "%.1f: Low UV index. If you burn easily, wear SPF 30+.", uv)
        return (shouldWear: true, spfRecText: text)
    case 3...5.99:
        print("UV 3-5")
        let text = String(format: "%.1f: Moderate UV index. Stay in the shade during midday. Apply SPF 30+ every 2 hours. Wear protective clothing and sunglasses.", uv)
        return (shouldWear: true, spfRecText: text)
    case 6...7.99:
        let text = String(format: "%.1f: High UV index. Apply SPF 30+ even if cloudy. Avoid being in the sun between 10 AM-4 PM.", uv)
        return (shouldWear: true, spfRecText: text)
    case 8...10.99:
        let text = String(format: "%.1f: Very high UV index. Apply SPF 30+ even if cloudy every 2 hours. Minimize sun exposure 10 AM-4 PM.", uv)
        return (shouldWear: true, spfRecText: text)
    case 11...:
        let text = String(format: "%.1f: Extreme UV index. Avoid sun exposure 10 AM-4 PM. Generously pply SPF 30+ even if cloudy every 2 hours.", uv)
        return (shouldWear: true, spfRecText: text)
    default:
        let text = "No recommendation"
        return (shouldWear: false, spfRecText: text)
    }
}

