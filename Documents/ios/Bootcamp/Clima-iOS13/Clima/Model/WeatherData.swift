//
//  WeatherData.swift
//  Clima
//
//  Created by yeawonKim on 21/05/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData : Codable {
    let name: String
    let main: Main
    let weather : [ Weather ]
}

struct Main : Codable {
    let temp: Double
}

struct Weather : Codable{
    let description: String
    let id: Int
}
