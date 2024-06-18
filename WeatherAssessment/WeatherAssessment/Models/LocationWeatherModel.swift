//
//  LocationWeatherModel.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 15/06/2024.
//

import Foundation

struct LocationWeatherModel: Codable {
    let coordinates: Coordinates
    let descriptions: [DescriptionModel]
    let base: String
    let main: MainWeatherInfo
    let visibility: Int
    let wind: WindSpeedInfo
    let general: GeneralInfo
    let dt: Int
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    enum CodingKeys: String, CodingKey {
        case coordinates = "coord"
        case descriptions = "weather"
        case general = "sys"
        case main
        case wind
        case timezone, id, name, cod, dt, base, visibility
    }
    
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let lon, lat: Double
}

// MARK: - MainWeatherInfo
struct MainWeatherInfo: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - GeneralInfo
struct GeneralInfo: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - DescriptionModel
struct DescriptionModel: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - WindSpeedInfo
struct WindSpeedInfo: Codable {
    let speed: Double
    let deg: Int
}
