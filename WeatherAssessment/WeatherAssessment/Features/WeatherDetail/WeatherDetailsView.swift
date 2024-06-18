//
//  WeatherDetailsView.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 15/06/2024.
//

import SwiftUI
import SFSafeSymbols
struct WeatherDetailsView: View {
    @ObservedObject var viewModel: WeatherDetailViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var sessionDataController: SessionDataController

    var body: some View {
        VStack {
            CustomNavigationBarView.configureWithLeftButton(
                handler: { self.presentationMode.wrappedValue.dismiss() },
                title: "",
                buttonImage: .init(systemSymbol: .xmark))
            
            
            Text(viewModel.title)
                .font(.headline)
                .padding(.top, -Style.Padding.single)
            
            Spacer()
            
            VStack(spacing: 20) {
                if let imageURL = viewModel.imageURL {
                    AsyncLoadingImageView(url:imageURL, frame: .init(width: 100, height: 100))
                        .scaledToFit()
                        .tint(.blue)
                }
                
                DetailsBoxView(viewState: $viewModel.viewState)
                    .environmentObject(sessionDataController)
                
                Spacer()
                
                Text(viewModel.footer)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, Style.Padding.double)
            }
        }
        .background(Color.gray.opacity(0.1))
        .edgesIgnoringSafeArea(.all)
    }
}

