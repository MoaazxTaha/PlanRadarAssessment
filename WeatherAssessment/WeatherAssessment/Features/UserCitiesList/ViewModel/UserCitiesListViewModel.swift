//
//  UserCitiesListViewModel.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 15/06/2024.
//

import Foundation
import Combine

class UserCitiesListViewModel: ObservableObject {
    private var cancellable = Set<AnyCancellable>()
    @Published var addCityPresented: Bool = false
    @Published var showCurrentWeatherDetails: Bool = false

    @Published var locations: [Location] = []
    var searchCitiesViewMdoel = LoactionSearchViewModel()
    var detailsViewModel: WeatherDetailViewModel? = nil

    
    init() {
        setupBinding()
    }
    
    private func setupBinding() {
        searchCitiesViewMdoel.$selectedSuggesionItem
            .sink { [weak self] location in
                guard let self, let location else { return }
                self.detailsViewModel = .init(location: location)
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                    self.showCurrentWeatherDetails = true
                }
            }
            .store(in: &cancellable)
    }
}
