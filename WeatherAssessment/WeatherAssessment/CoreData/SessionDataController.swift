//
//  SessionDataController.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 17/06/2024.
//

import Foundation

class SessionDataController: ObservableObject {
    @Published var locations: [Location] = []
    @Published var allWeatherInfos: [WeatherInfo] = []
    @Published var selectedLocation: Location?
    @Published var selectedHistoricalRecord: LocationWeatherViewModel?
}
