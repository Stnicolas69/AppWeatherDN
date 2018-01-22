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
    let icon: String
}
struct Current: Codable {
    let temp_c: Double
    let condition: Condition
}


struct Object: Codable {
    let location: Location
    let current: Current
}
