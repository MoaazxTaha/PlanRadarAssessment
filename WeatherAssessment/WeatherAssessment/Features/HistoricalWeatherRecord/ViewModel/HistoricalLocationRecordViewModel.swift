//
//  HistoricalLocationRecordViewModel.swift
//  TryCitiesListView
//
//  Created by Moaaz Ahmed Fawzy Taha on 14/06/2024.
//

import Foundation
import Combine
import SwiftUI

class HistoricalLocationRecordViewModel: ObservableObject {
    private var cancellable = Set<AnyCancellable>()
    @Published var viewState: ViewState<[LocationWeatherViewModel]> = .loading
    @Published var title: String = ""
    @Published var isDetailPresented: Bool = false
    @Published var selectedItem: LocationWeatherViewModel?

    var detailsViewModel: WeatherDetailViewModel? = nil
    let location: Location
    
    init(selectedLocation: Location) {
        location = selectedLocation
        setupBinding()
    }
    
    private func setupBinding() {
        $selectedItem
            .sink { [weak self] weatherInfo in
                guard let self, let weatherInfo else { return }
                self.detailsViewModel = .init(weatherInfo: weatherInfo.item)
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                    self.isDetailPresented = true
                }
            }
            .store(in: &cancellable)

    }
    
    func updateWeatherInfos(with weatherInfos: [WeatherInfo]) {
        let filteredWeatherInfo  = weatherInfos.filter { $0.cityName ==  location.name}
        if !filteredWeatherInfo.isEmpty, let samlpleItem = filteredWeatherInfo.first {
            if let cityName = samlpleItem.cityName {
                title = "\(cityName) \n Historical".uppercased()
            }
            let items = filteredWeatherInfo.map { LocationWeatherViewModel(item: $0) }
            viewState = .content(items, nil)
        } else {
            viewState = .empty
        }
    }
}
