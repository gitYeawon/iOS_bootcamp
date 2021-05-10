//
//  WeatherModel.swift
//  Clima
//
//  Created by yeawonKim on 31/05/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let tamperature: Double
    
    var temperatureString: String{
        return String(format: "%.1f", tamperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "smoke"
        case 800:
            return "sparkles"
        case 801...804:
            return "cloud"
        default:
            return "sun.dust"
        }
    }
    
    //    func getConditionName(weatherId: Int) -> String {
    //    }
    //
}


