//
//  DetailsBoxVieWModel.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 17/06/2024.
//

import Combine

class DetailsBoxVieWModel: ObservableObject {
    var fetchedItem: LocationWeatherModel?
    @Published var describtion: String = ""
    @Published var temprature: String = ""
    @Published var humidity: String = ""
    @Published var windSpeed: String = ""

    init(item: LocationWeatherModel) {
        if let description = item.descriptions.first?.description {
            self.describtion = description
        }
        self.fetchedItem = item
        self.temprature = Formatter.convertTemp(temp: item.main.temp, from: .kelvin, to: .celsius)
        self.humidity = "\(item.main.humidity) %"
        self.windSpeed = String(item.wind.speed) + "Km/h"
    }
    
    init(historicalItem: WeatherInfo) {
        describtion = historicalItem.descriptionTitle ?? ""
        temprature = Formatter.convertTemp(temp: Double(historicalItem.temprature), from: .kelvin, to: .celsius)
        humidity = "\(Int(historicalItem.humidity)) %"
        windSpeed = String(Int(historicalItem.windSpeed)) + "Km/h"
    }
}
