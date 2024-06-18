//
//  ContentView.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 15/06/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var sessionDataController = SessionDataController()
    @FetchRequest (sortDescriptors: []) var locations: FetchedResults<Location>
    @FetchRequest (sortDescriptors: []) var weatherInfos: FetchedResults<WeatherInfo>

    var body: some View {
        UserCitiesListView()
            .environmentObject(sessionDataController)
            .onAppear {
                sessionDataController.locations = locations.compactMap { $0 }
                sessionDataController.allWeatherInfos = weatherInfos.compactMap { $0 }
            }
    }
}
