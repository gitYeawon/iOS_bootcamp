//
//  WeatherManager.swift
//  Clima
//
//  Created by yeawonKim on 21/05/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager:WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}//protocol should be in same file as we use the protocol

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=7a563baa7901dda75eb133ee7ada7d66&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchURL(latitute: CLLocationDegrees ,longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitute)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func fetchURL(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
            //1. create a URL
            if let url = URL(string: urlString){
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a take
            let task = session.dataTask(with: url){ (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    //let dataString = String(data: safeData, encoding: .utf8)
                    //print(dataString)
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    //        func handel(data: Data?, response: URLResponse?, error: Error?) {
    //        }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, tamperature: temp)
            
            return weather
            
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    }
    

