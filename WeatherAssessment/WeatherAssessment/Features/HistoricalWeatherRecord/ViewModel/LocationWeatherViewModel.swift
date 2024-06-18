//
//  LocationWeatherModel.swift
//  TryCitiesListView
//
//  Created by Moaaz Ahmed Fawzy Taha on 14/06/2024.
//

import Foundation
import SwiftUI

struct LocationWeatherViewModel: Hashable {
    let item: WeatherInfo
    let id: Int?
    let date: Date?
    let city: String?
    let country: String?
    let description: String?
    let temprature: Int?
    
    init(item: WeatherInfo) {
        self.item = item
        self.id = Int(item.id)
        self.date = item.date
        self.city = item.cityName
        self.country = item.countryIntials
        self.description = item.descriptionTitle
        self.temprature = Int(item.temprature)
    }
    
    var dateString: String {
        guard let date else { return "" }
        return date.formatted(date: .numeric, time: .shortened)
    }
    
    var descriptionLine: String {
        let tempratureString: String? = {
            let unitFormatter = MeasurementFormatter()
            guard let temprature else { return nil }
            let temperatureFormatter = Measurement(value: Double(temprature), unit: UnitTemperature.celsius)
            return unitFormatter.string(from: temperatureFormatter)
        }()
        
        return [description, tempratureString].compactMap { $0 } .joined(separator: ", ")
    }
}
