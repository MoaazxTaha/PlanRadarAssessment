//
//  WeatherDetailViewModel.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 15/06/2024.
//

import Foundation
import Combine

class WeatherDetailViewModel: ObservableObject {
    private var cancellable = Set<AnyCancellable>()
    @Published var viewState: ViewState<DetailsBoxVieWModel> = .loading
    @Published var imageURL: String? = nil
    @Published var title: String = ""
    @Published var footer: String = ""
    
    init(location: LocationModel) {
        fetchData(for: location)
    }
    
    init(weatherInfo: WeatherInfo) {
        let detailBoxViewModel = DetailsBoxVieWModel(historicalItem: weatherInfo)
        self.title = [weatherInfo.cityName, weatherInfo.countryIntials].compactMap { $0 }.joined(separator: " ")
        self.viewState = .content(detailBoxViewModel, nil)
        if let cityName = weatherInfo.cityName {
            footer = [footer, "WEATHER INFORMATION FOR \(cityName) "].joined(separator: " ")
        }
        if let date = weatherInfo.date?.formatted(date: .numeric, time: .shortened) {
            footer = [footer, "RECEIVED ON \n\(date) "].joined(separator: " ")
        }
        
        if let iconID = weatherInfo.imageId,
           let url = APIEndPoints.imageURL(withId: String(iconID)) {
            self.imageURL = url.absoluteString
        }
    }
    
    private func fetchData(for locationModel: LocationModel) {
        APIClient.shared.requestWithAPI(.getWeather, parameters: ["locationName": locationModel.title])
            .sink(receiveCompletion: { [weak self] result in
                guard let self else { return }
                switch result {
                    case .finished:
                        // Handle successful completion if needed
                        break
                    case .failure(let error):
                        // Handle the error here
                        self.viewState = .failed(error)
                }
                
            }, receiveValue:{ [weak self] (result: LocationWeatherModel) in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.title = [result.name, result.general.country].joined(separator: " ")
                    let detailBoxViewModel = DetailsBoxVieWModel(item: result)
                    self.viewState = .content(detailBoxViewModel, nil)
                    if let iconID = result.descriptions.first?.icon,
                       let url = APIEndPoints.imageURL(withId: String(iconID)) {
                        self.imageURL = url.absoluteString
                    }
                    let dateToday = Date().formatted(date: .numeric, time: .shortened)
                    self.footer = "WEATHER INFORMATION FOR \(result.name) RECEIVED ON \n\(dateToday)"
                }
            })
            .store(in: &cancellable)
    }
}
