//
//  Location.swift
//  WeatherTeller
//
//  Created by Milja V on 2018-03-19.
//  Copyright © 2018 Milja V. All rights reserved.
//

import Foundation
import UIKit

class Location {
    
    var weatherIcon: UIImage
    var title: String
    var weatherExplanation: String
    var degrees: String
    
    init(weatherIcon: UIImage, title: String, weatherExplanation: String, degrees: String) {
        self.weatherIcon = weatherIcon
        self.title = title
        self.weatherExplanation = weatherExplanation
        self.degrees = degrees
        
    }
    
}
