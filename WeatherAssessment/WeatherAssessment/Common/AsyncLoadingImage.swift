//
//  AsyncLoadingImage.swift
//  WeatherAssessment
//
//  Created by Moaaz Ahmed Fawzy Taha on 17/06/2024.
//

import SwiftUI
import UIKit

struct AsyncLoadingImageView: View {
    var url: String
    var frame: CGSize?

    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                if let frame {
                    image
                        .resizable()
                        .frame(width: frame.width, height: frame.height)
                } else {
                    image
                        .resizable()
                }
            } else if phase.error != nil {
                Text("Couldn't load Image")
                    .padding()
            } else {
                ProgressView()
                    .frame(width: 100, height: 100)
                    .padding()
            }
        }
        .onAppear {
            print("## imageURL: \(url)")
        }
    }
}
