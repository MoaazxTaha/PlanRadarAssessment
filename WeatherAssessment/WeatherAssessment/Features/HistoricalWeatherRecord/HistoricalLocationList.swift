//
//  HistoricalLocationList.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 17/06/2024.
//

import SwiftUI
import SFSafeSymbols

struct HistoricalLocationList: StatefulView {
    var viewState: Binding<ViewState<[LocationWeatherViewModel]>>
    @ObservedObject var viewModel: HistoricalLocationRecordViewModel
    
    init(viewState: Binding<ViewState<[LocationWeatherViewModel]>>, viewModel: HistoricalLocationRecordViewModel) {
        self.viewState = viewState
        self.viewModel = viewModel
    }
    
    func content(_ content: [LocationWeatherViewModel]) -> some View {
        List(content, id: \.self, selection: $viewModel.selectedItem) { waetherItem in
            historicalWeatherItem(waetherItem)
        }
        .listRowSeparator(.visible)
        .listStyle(.plain)
    }
    
    private func historicalWeatherItem(_ item: LocationWeatherViewModel) -> some View {
        VStack {
            Text(item.dateString)
                .font(.body)
            Text(item.descriptionLine)
                .font(.caption)
                .foregroundColor(.blue)
        }
    }
    
    func loadingView() -> some View {
        StatefulLoadingView()
    }
    
    func errorView(_ error: Error) -> some View {
        StatefulEmptyView(title: "Something happened wrong with retriving your weather record for the selected location", systemSumbl: .xCircle)
    }
    
    func emptyView() -> some View {
        StatefulEmptyView(title: "Something happened wrong with retriving your weather record for the selected location", systemSumbl: .folderCircle)
    }
}

