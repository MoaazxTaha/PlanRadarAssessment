//
//  UserCitiesList.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 15/06/2024.
//

import SwiftUI
import SFSafeSymbols

struct UserCitiesListView: View {
    @ObservedObject var viewModel = UserCitiesListViewModel()
    @EnvironmentObject var sessionDataController: SessionDataController
    @FetchRequest (sortDescriptors: []) var locations: FetchedResults<Location>
    @FetchRequest (sortDescriptors: []) var weatherInfos: FetchedResults<WeatherInfo>

    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                CustomNavigationBarView.configureWithRightButton(
                    handler: {
                        viewModel.addCityPresented = true
                    },
                    title: "Cities",
                    buttonImage: Image(systemSymbol: .plus)
                )
                .sheet(isPresented: $viewModel.addCityPresented, onDismiss: {
                    viewModel.addCityPresented = false
                }) {
                    SearchCitiesView(viewModel: viewModel.searchCitiesViewMdoel)
                        .environmentObject(sessionDataController)
                }
                .sheet(isPresented: $viewModel.showCurrentWeatherDetails, onDismiss: {
                    sessionDataController.selectedLocation = nil
                    viewModel.showCurrentWeatherDetails = false
                    sessionDataController.locations = locations.compactMap { $0 }
                    sessionDataController.allWeatherInfos = weatherInfos.compactMap { $0 }
                }) {
                    if let viewModel = viewModel.detailsViewModel {
                        WeatherDetailsView(viewModel: viewModel)
                    }
                }
                
                .padding(.top, Style.Padding.triple)
                List(sessionDataController.locations, id: \.self) { location in
                    cityListItem(location: location)
                }
                .listRowSeparator(.visible)
                .listStyle(.plain)
            }
        }
        .background {
            Image("background")
        }
    }
    
    
    private func cityListItem(location: Location) -> some View {
        ZStack {
            NavigationLink {
                HistoricalLocationRecordView(viewModel: HistoricalLocationRecordViewModel(selectedLocation: location))
            } label: {
                EmptyView()
            }
            
            HStack {
                Text(location.name ?? "<< Error presenting location >>")
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.blue)
            }
            
        }
        .padding(Style.Padding.double)
    }
}
