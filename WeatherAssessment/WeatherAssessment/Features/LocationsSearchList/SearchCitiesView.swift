//
//  SearchCitiesView.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 15/06/2024.
//

import SwiftUI

struct SearchCitiesView: View {
    @StateObject var viewModel: LoactionSearchViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var sessionDataController: SessionDataController

    var body: some View {
            NavigationView {
                VStack(alignment: .leading) {
                    List(viewModel.viewData, id: \.self) { item in
                        suggesionListItem(for: item, isSelected: item == viewModel.selectedSuggesionItem)
                    }
                    .listStyle(.plain)
                }
                .ignoresSafeArea(edges: .bottom)
                .navigationTitle("Enter city, postcode or airoport location")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $viewModel.searchText)
            }
            .onAppear {
                CustomNavigationBarView.updateSmallTitleAppearanceWithCustomFont()
            }
    }
    
    private func suggesionListItem(for item: LocationModel, isSelected: Bool) -> some View {
        VStack(alignment: .leading) {
            Text(.init(item.title))
                .foregroundColor( isSelected ? .white : .primary)
        }
        .onTapGesture {
            self.presentationMode.wrappedValue.dismiss()
            viewModel.selectedSuggesionItem = item
        }

    }
}
