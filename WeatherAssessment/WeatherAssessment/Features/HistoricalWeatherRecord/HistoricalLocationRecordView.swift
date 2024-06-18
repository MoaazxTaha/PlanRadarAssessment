//
//  HistoricalLocationRecordView.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 15/06/2024.
//

import SwiftUI
import SFSafeSymbols

struct HistoricalLocationRecordView: View {
    @ObservedObject var viewModel: HistoricalLocationRecordViewModel
    @EnvironmentObject var sessionDataController: SessionDataController
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(viewModel: HistoricalLocationRecordViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .center, content: {
            CustomNavigationBarView.configureWithLeftButton(
                handler: { self.presentationMode.wrappedValue.dismiss() },
                title: viewModel.title,
                buttonImage: .init(systemSymbol: .arrowLeft)
            )
            
            HistoricalLocationList(viewState: $viewModel.viewState, viewModel: viewModel)
        })
        .onAppear {
            viewModel.updateWeatherInfos(with: sessionDataController.allWeatherInfos)
        }
        .sheet(isPresented: $viewModel.isDetailPresented, onDismiss: {
            viewModel.isDetailPresented = false
            viewModel.selectedItem = nil
            viewModel.detailsViewModel = nil
        }) {
            if let selectedItem = viewModel.selectedItem,
               let detailViewModel = viewModel.detailsViewModel {
                WeatherDetailsView(viewModel: detailViewModel)
            }
        }
    }
}
