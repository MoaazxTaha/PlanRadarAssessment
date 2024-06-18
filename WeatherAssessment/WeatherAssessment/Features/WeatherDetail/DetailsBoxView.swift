//
//  DetailsBoxsView.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 17/06/2024.
//

import SwiftUI

struct DetailsBoxView: StatefulView {
    var viewState: Binding<ViewState<DetailsBoxVieWModel>>
    @Environment (\.managedObjectContext) var coreDataContext
    @EnvironmentObject var sessionDataController: SessionDataController

    init(viewState: Binding<ViewState<DetailsBoxVieWModel>>) {
        self.viewState = viewState
    }
    
    func content(_ viewModel: DetailsBoxVieWModel) -> some View {
        VStack(alignment: .leading, spacing: Style.Padding.medium) {
            if !viewModel.describtion.isEmpty {
                detailItem(title: "DESCRIPTION", description: viewModel.describtion)
            }
            if !viewModel.temprature.isEmpty {
                detailItem(title: "TEMPERATURE", description: viewModel.temprature)
            }
            if !viewModel.humidity.isEmpty {
                detailItem(title: "HUMIDITY", description: viewModel.humidity)
            }
            if !viewModel.windSpeed.isEmpty {
                detailItem(title: "WINDSPEED", description: viewModel.windSpeed)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(.vertical)
        .padding(.horizontal, Style.Padding.triple)
        .onAppear {
            if let fetchedItem = viewModel.fetchedItem {
                saveToCoreData(fetchedItem, with: viewModel, in: sessionDataController.locations)
            }
        }
    }
    
    private func detailItem(title: String, description: String) -> some View {
        return HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
            Text(description.capitalized)
                .font(.subheadline)
                .bold()
                .foregroundColor(.blue)
        }
    }
    
    func loadingView() -> some View {
        StatefulLoadingView()
    }
    
    func errorView(_ error: Error) -> some View {
        StatefulEmptyView(title: "Something happened wrong with fetching Weather Details. \n This location might not have weather deatails info in our database. please try another location", systemSumbl: .xCircle)
    }
    
    func emptyView() -> some View {
        StatefulEmptyView(title: "This location might not have weather deatails info in our database. please try another location", systemSumbl: .folderCircle)
    }
}

// MARK: - Update Core Data
extension DetailsBoxView {
    private func saveToCoreData(_ item: LocationWeatherModel, with viewModel: DetailsBoxVieWModel, in locations: [Location]) {
        let weatherInfo = WeatherInfo(context: coreDataContext)
        weatherInfo.id = Int64(item.id)
        weatherInfo.date = Date()
        weatherInfo.cityName = item.name
        weatherInfo.countryIntials = item.general.country
        weatherInfo.temprature = Int16(Int(item.main.temp))
        weatherInfo.windSpeed = Int16(Int(item.wind.speed))
        weatherInfo.humidity = Int16(item.main.humidity)
        weatherInfo.imageId =  item.descriptions.first?.icon
        weatherInfo.descriptionTitle = viewModel.describtion
                
        if locations.first(where: { $0.name == item.name }) == nil {
            let location = Location(context: coreDataContext)
            location.id = Int64(Int32(item.id))
            location.name = item.name
        }
        
        do {
            try coreDataContext.save()
        }
        
        catch {
            print("## Failed to save info with error: \(error.localizedDescription)")
        }
    }
}
