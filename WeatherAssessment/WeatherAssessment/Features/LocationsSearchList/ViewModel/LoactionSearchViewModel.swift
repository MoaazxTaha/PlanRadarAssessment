//
//  LoactionSearchViewModel.swift
//  TryCitiesListView
//
//  Created by Moaaz Ahmed Fawzy Taha on 14/06/2024.
//

import Foundation
import MapKit
import Combine

public class LoactionSearchViewModel: ObservableObject {
    private var cancellable = Set<AnyCancellable>()

    @Published var searchText = ""
    @Published public var selectedSuggesionItem: LocationModel?
    @Published var viewData = [LocationModel]()

    var service: LocationSearchService
    
    init() {
        // Vienna
        let center = CLLocationCoordinate2D(latitude: 48.2081, longitude: 16.3713)
        service = LocationSearchService(in: center)
        
        setupBinding()
    }
    
    private func setupBinding() {
        service.locationSearchPublisher
            .assign(to: \.viewData, on: self)
            .store(in: &cancellable)
        
        _searchText
            .projectedValue
            .filter { !$0.isEmpty }
            .sink(receiveValue: { [weak self] searchText in
                guard let self else { return }
                self.searchForCity(text: searchText)
            })
            .store(in: &cancellable)
        
        _searchText
            .projectedValue
            .filter { $0.isEmpty }
            .sink(receiveValue: { [weak self] searchText in
                guard let self else { return }
                self.viewData = []
            })
            .store(in: &cancellable)

    }
    
    private func searchForCity(text: String) {
        service.searchCities(searchText: text)
    }    
}
