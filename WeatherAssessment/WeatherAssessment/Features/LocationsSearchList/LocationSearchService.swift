//
//  LocationSearchService.swift
//  TryCitiesListView
//
//  Created by Moaaz Ahmed Fawzy Taha on 14/06/2024.
//

import Foundation
import Combine
import MapKit

final class LocationSearchService: NSObject {
    let locationSearchPublisher = PassthroughSubject<[LocationModel], Never>()
    private lazy var completer = MKLocalSearchCompleter()
    private var region: MKCoordinateRegion


    init(in center: CLLocationCoordinate2D,
         radius: CLLocationDistance = .infinity) {
        self.region = MKCoordinateRegion(center: center, latitudinalMeters: radius, longitudinalMeters: radius)
        super.init()
        
        setupSearchCompleter()
    }
    
    private func setupSearchCompleter() {
        completer.delegate = self
        completer.resultTypes = .address
        completer.pointOfInterestFilter = .includingAll
        completer.region = region
    }
    public func searchCities(searchText: String) {
        searchAddressesForText(searchText)
    }
        
    func searchAddressesForText(_ text: String) {
        completer.queryFragment = text
    }
}

extension LocationSearchService: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let resultSuggesionItems = completer.results.map { LocationModel(suggesionItem: $0) }
        locationSearchPublisher.send(resultSuggesionItems)
    }
}
