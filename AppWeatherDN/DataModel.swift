//
//  File.swift
//  AppWeatherDN
//
//  Created by iOS Akademija on 1/19/18.
//  Copyright © 2018 iOS Akademija. All rights reserved.
//

import Foundation

struct Location: Codable {
    let name: String
}

struct Condition: Codable {
    var text: String
    var icon: String
    var code: Int
}
struct Current: Codable {
    let temp_c: Double
    let condition: Condition
    let wind_kph: Double
    let humidity: Double
    let precip_in: Double
    let pressure_mb: Double
}


struct Object: Codable {
    let location: Location
    let current: Current
}
